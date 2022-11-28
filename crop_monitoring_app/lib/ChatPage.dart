import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ChatPage extends StatefulWidget {
  final BluetoothDevice server;

  const ChatPage({required this.server});

  @override
  _ChatPage createState() => new _ChatPage();
}

class _Message {
  int whom;
  String text;
  _Message(this.whom, this.text);
}

class MessageData {
  String text;
  MessageData(
    this.text,
  );

  static List<String> temperature = List<String>.empty(growable: true);
  static List<String> soilMoisture = List<String>.empty(growable: true);
  static List<String> humidity = List<String>.empty(growable: true);

  void setData() {
    List<String> data = this.text.split(" ");
    if (temperature.length < 10) {
      temperature.add(data[0]);
      humidity.add(data[1]);
      soilMoisture.add(data[2]);
    } else {
      temperature.removeLast();
      soilMoisture.removeLast();
      humidity.removeLast();
      temperature.add(data[0]);
      humidity.add(data[1]);
      soilMoisture.add(data[2]);
    }
    // data.asMap().forEach((index, value) {
    //   debugPrint(index.toString() + " " + value);
    // });
  }

  static String getTemperature() {
    double mean = 0;
    temperature.forEach((element) {
      mean += double.parse(element);
    });
    mean = mean / temperature.length;
    return mean.toStringAsFixed(2);
  }

  static String getSoilMoisture() {
    double mean = 0;
    soilMoisture.forEach((element) {
      mean += double.parse(element);
    });
    mean = mean / soilMoisture.length;
    return mean.toStringAsFixed(2);
  }

  static String getHumidity() {
    double mean = 0;
    humidity.forEach((element) {
      mean += double.parse(element);
    });
    mean = mean / humidity.length;
    return mean.toStringAsFixed(2);
  }
}

class _ChatPage extends State<ChatPage> {
  static final clientID = 0;
  BluetoothConnection? connection;

  List<_Message> messages = List<_Message>.empty(growable: true);
  List<String> features = [
    'Temperature',
    'Humidity',
    'Soil Moisture',
    'Rainfall'
  ];
  String _messageBuffer = '';
  late String temp, hum, mosit;
  late _ChartData chartData_;

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      debugPrint('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection!.input!.listen(_onDataReceived).onDone(() {
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          // connection?.input!.listen(_onDataReceived);
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    messages.forEach((_message) {
      MessageData messageData = MessageData(_message.text.trim());
      // debugPrint(_message.text.trim());
      messageData.setData();
    });

    final GridView gridView = GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 150, 200, 244),
            borderRadius: BorderRadius.circular(30),
          ),
          // color: Colors.blue,
          child: grid(index, features),
          margin: const EdgeInsets.all(20),
        );
      },
    );

    final serverName = widget.server.name ?? "Unknown";

    return Scaffold(
      appBar: AppBar(
          title: (isConnecting
              ? Text('Connecting to ' + serverName + '...')
              : isConnected
                  ? Text('Connected with ' + serverName)
                  : Text('Chat log with ' + serverName))),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Flexible(
              child: Container(
                  padding: const EdgeInsets.all(12.0),
                  // controller: listScrollController,
                  child: gridView),
            ),
            Divider(),
            chartContainer("Temperature"),
            Row(
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(left: 16.0),
                    child: TextField(
                      style: const TextStyle(fontSize: 15.0),
                      controller: textEditingController,
                      decoration: InputDecoration.collapsed(
                        hintText: isConnecting
                            ? 'Wait until connected...'
                            : isConnected
                                ? 'Type your message...'
                                : 'Chat got disconnected',
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                      enabled: isConnected,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: isConnected
                          ? () => _sendMessage(textEditingController.text)
                          : null),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onDataReceived(Uint8List data) {
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });

    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    // MessageData messageData;
    // debugPrint(dataString);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                    0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
        // if (backspacesCounter > 0) {
        //   messageData = MessageData(_messageBuffer.substring(
        //       0, _messageBuffer.length - backspacesCounter));
        //   messageData.setData();
        // } else {
        //   messageData =
        //       MessageData(_messageBuffer + dataString.substring(0, index));
        //   messageData.setData();
        // }
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  void _sendMessage(String text) async {
    text = text.trim();
    textEditingController.clear();

    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text)));
        await connection!.output.allSent;

        // setState(() {
        // messages.add(_Message(clientID, text));
        // });

        Future.delayed(Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 333),
              curve: Curves.easeOut);
        });
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }

  Container chartContainer(String title) {
    DateTime now = DateTime.now();
    int counter = 0;
    List<_ChartData> liveChartData = List<_ChartData>.empty(growable: true);
    List<String> messageData_ = MessageData.temperature.toList();

    messageData_.forEach((e) {
      // String time = DateFormat('ss').format(now);
      if (counter >= 60) {
        counter = 0;
      }

      chartData_ = new _ChartData(e.toString(), (counter++).toString());
      liveChartData.add(
        chartData_,
      );
    });
    // debugPrint(liveChartData.);
    // liveChartData.forEach((element) {
    //   debugPrint(element.val.toString() + " " + element.time.toString());
    // });

    return Container(
      child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          title: ChartTitle(text: title),
          // legend: Legend(isVisible: true),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries<_ChartData, String>>[
            LineSeries<_ChartData, String>(
              dataSource: liveChartData,
              xValueMapper: (_ChartData data_, _) => data_.time,
              yValueMapper: (_ChartData data_, _) => double.parse(data_.val),
              name: 'Celsius',
              dataLabelSettings: DataLabelSettings(isVisible: false),
            )
          ]),
    );
  }
}

class _ChartData {
  _ChartData(this.val, this.time);

  final String val;
  final String time;
}

Center grid(int index, List<String> features) {
  String featureName = features[index];
  String val = '0';
  switch (index) {
    case 0:
      String temp = MessageData.getTemperature();
      val = temp;
      break;
    case 1:
      String hum = MessageData.getHumidity();
      val = hum;
      break;
    case 2:
      String moist = MessageData.getSoilMoisture();
      val = moist;
      break;
    default:
      val = "00.00";
  }
  return Center(
    child: Text(featureName + "\n" + val),
  );
}
