# Crop Monitoring Smart Agriculture

CS3282 - Industrial Computer Engineering Project

<hr/>
<img src="https://user-images.githubusercontent.com/77115237/190918463-30444397-b4fa-42d4-a588-f7cb4a0e9d99.png" width="100%" height ="auto">
<br/>
<h3>Introduction</h3>
<p>
 This project 'Crop Monitoring Smart Agriculture' helps farmers to apply the right amount of fertilizers to the fields. A portable device is proposed to be built in this project to measure the required measurements such as temperature, Humidity, Soil moisture, Electric conductivity of soil, NPK, Rainfall and PH. Rainfall is needed to be fetched from an <a href="https://openweathermap.org" target="_blank">API</a> as this includes a portable device. The <a href="#integration-diagram">integration diagram</a> is shown below. The control of the device and visualization of the measurements are done using an Android Application . Data is transferred from the device to Android application via Bluetooth in JSON format by a well-defined API. 
</p>
<p>
An additional feature 'Plant leaf disease detection' is employed within the android application to detect and identify the disease of a plan leaf. This detection and identification provides the farmers with the name of the disease, thus necessary actions could be taken. The sensor data will be transmitted to a cloud server through the internet. The system is required to be compact and energy efficient.
</p>

<img src="https://github.com/imshaaz21/Crop-Monitoring-Smart-Agriculture/blob/main/Asserts/White%20Photo%20Collage%20Morning%20Routine%20Instagram%20Story.png" width="100%" height ="auto">

<h3>Integration Diagram</h3>
<p align="center">
  <img src="https://user-images.githubusercontent.com/77115237/190919428-3022987a-fb9c-4c6d-9885-e8b3af84eaf1.png" width="50%" height = "auto">
</p>

<h3>Developed Android App</h3>
<p align="center">
  <img src="https://github.com/imshaaz21/Crop-Monitoring-Smart-Agriculture/blob/main/Asserts/index.jpg" width="50%" height = "auto">
</p>


<h3>IoT device</h3>
<p align="center">
  <img src="https://user-images.githubusercontent.com/77115237/192459982-a9886b5d-f546-48aa-bd7b-36dff87d50e4.png" width="50%" height = "auto">
</p>
<hr/>
<h3>Procedure</h3>
<p>This project is mixture of hardware and software components. The hardware part includes the embedded system which programs in Arduino IDE. Arduino Uno is used to build this project. The special sensors used to measure humidity, soil moisture, temperature,ph & soil electric conductivity. LEDs & LCD screen used to indicates the connectivity and the battery level. A bluetooth module is used to communicate with android app. </p>
<br/>
<table>
 <tr>
  <td>Arduino Uno</td>
   <td><img src="https://user-images.githubusercontent.com/77115237/192482471-ee8c8d8f-440c-48fa-9e42-9d28ba3b760b.png" width="100px" height = "100px"></td>
  <td><ul><li>Microcontroller: ATmega328P.</li>
<li>Operating Voltage: 5V.</li>
<li>Input Voltage (recommended): 7-12V.</li>
<li>Inout Voltage (limit): 6-20V.</li>
<li>Digital I/O Pins: 14 </li>
<li>Analog Input Pins: 6.</li>
<li>DC Current per I/O Pin: 20 mA.</li></ul></td>
 </tr>
 <tr>
  <td>DHT22 Temperature And Humidity Sensor</td>
   <td><img src="https://nilambaraelectronics.com/wp-content/uploads/2022/01/AM2302-DHT22-Digital-Temperature-and-Humidity-Sensor-Module.jpg"  width="100px" height = "100px"></td>
  <td>
      <ul><li>Humidity range: 0-100%RH. </li><li>Temperature range: -40~80℃.</li>   <li>  Humidity measurement precision: ±2%RH</li></ul></td>
 </tr>
 <tr>
  <td>Soil Moisture sensor</td>
   <td><img src="https://user-images.githubusercontent.com/77115237/192483809-f0041020-b8d8-468f-94eb-9dbaad54a8db.png"  width="100px" height = "100px"></td>
  <td><ul><li>Soil moisture sensors measure or estimate the amount of water in the soil.</li></ul></td>
 </tr>
 <tr>
  <td>Bluetooth Module HC-05</td>
   <td><img src="https://user-images.githubusercontent.com/77115237/192485152-11f5e92e-71ad-4576-958c-2e9d23efd0fd.png"  width="100px" height = "100px"></td>
  <td><ul><li>This module used to communicate with android app. HC 05 works on serial communication.</li> </ul></td>
 </tr>
</table>
<br/>



<hr/>
<h3>Timeline</h3>
<img src="https://user-images.githubusercontent.com/77115237/191091547-8c6bed8d-6aa8-43f1-9516-c97f614a6077.png" width="100%" height = "auto">
<br/>
<hr/>
<h3>Progress</h3>
 <table>
  <th>Date</th>
  <th>Implementation</th>
  <tr>
   <td>06/09/2022</td>
   <td>Project proposal evaluation</td>
  </tr>
  <tr>
   <td>19/09/2022</td>
   <td>Updated the ReadMe<br>Requirement finalization</td>
  </tr>
  <tr>
   <td>27/09/2022</td>
   <td>
    <ul>
     <li>Collected sensors from SLIoT lab. (Arduino Uno, LCD display, Soil moisture sensor)</li>
     <li>Learning React Native app development</li>
     <li>Learning deep learning for disease detection</li>
    </ul>
   </td>
  </tr>
  <tr>
   <td>31/10/2022</td>
   <td>App Development</td>
  </tr>
  <tr>
 </table>
 <br/>
 <hr/>
<h3>Reference</h3>
<ul>
 <li>
  <p><b>IoT-based Soil Nutrient Analyser using Gaussian Process Regression</b><br/>
  I. Senevirathne, T. Ambegoda, R. Wijesena and I. Perera, "IoT-based Soil Nutrient Analyser using Gaussian Process Regression," 2022 2nd International Conference on Advanced Research in Computing (ICARC), 2022, pp. 7-12, doi: 10.1109/ICARC54489.2022.9754105.<p>
  </li>
</ul>
<br/>
<hr/>
<h3>Materials</h3>
<table>
  <tr>
    <td>Crop analysis and prediction</td>
    <td>https://www.kaggle.com/code/theeyeschico/crop-analysis-and-prediction</td>
  </tr>
  <tr>
    <td>Plant Disease Classification - ResNet- 99.2%</td>
    <td>https://www.kaggle.com/code/atharvaingle/plant-disease-classification-resnet-99-2</td>
  </tr>
  <tr>
    <td>Measure soil npk values</td>
    <td>https://www.circuitschools.com/measure-soil-npk-values-using-soil-npk-sensor-with-arduino/</td>
  </tr>
  <tr>
    <td>Planr disease images</td>
    <td>https://www.kaggle.com/datasets/abdallahalidev/plantvillage-dataset</td>
  </tr>
</table>
