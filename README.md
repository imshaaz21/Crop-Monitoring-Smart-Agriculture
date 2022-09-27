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

<h3>Integration Diagram</h3>
<p align="center">
  <img src="https://user-images.githubusercontent.com/77115237/190919428-3022987a-fb9c-4c6d-9885-e8b3af84eaf1.png" width="50%" height = "auto">
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
   <td><img src="https://user-images.githubusercontent.com/77115237/192482471-ee8c8d8f-440c-48fa-9e42-9d28ba3b760b.png" width="100%" height = "auto"></td>
  <td>Arduino is a micro controller to control the working of the sensors and manage the working of the device. The Uno version of Arduino is implemented in this project. It was developed by Arduino CC. The Arduino board comes with various number of pins. The pins are categorized as output and input pins. The input pins accepts digital as well as analog pins. It has 14 digital pins and 6 analog pins. It accepts 7 to 20 volts of power for working. It also has an USB port.</td>
 </tr>
 <tr>
  <td>DHT11 Temperature And Humidity Sensor</td>
   <td><img src="https://user-images.githubusercontent.com/77115237/192482606-a3f14aab-bb81-4f5b-a37e-990766ddef59.png" width="100%" height = "auto"></td>
  <td>The DHT11 Temperature And Humidity sensor is used to sense temperature and humidity present in the atmosphere. It has 3 pins generally. One pin is used for transmitting signals, the next pin is used to receive signals and the last pin is data transfer. It can be used for prolonged time period. It gives approximate results. It regularly sends information to Arduino Uno. The information consists the signals which contain the values gathered about temperature and humidity. It is reliable on nature. It gives a very fast response.</td>
 </tr>
 <tr>
  <td>Soil Moisture sensor</td>
   <td><img src="https://user-images.githubusercontent.com/77115237/192483809-f0041020-b8d8-468f-94eb-9dbaad54a8db.png" width="100%" height = "auto"></td>
  <td>The Soil Moisture sensor is used to sense moisture content in the soil. It checks the volume of water content or moisture present in the soil. The calculations are done in the soil moisture sensor through coefficients. It estimates the volume of water content in the soil. It detects the water content in the soil and gets and sends the analog signals which is shown digitally. It transmits the the signals containing information or data or values of the condition of soil to Arduino to further process it </td>
 </tr>
 <tr>
  <td>Bluetooth Module HC-05</td>
   <td><img src="https://user-images.githubusercontent.com/77115237/192485152-11f5e92e-71ad-4576-958c-2e9d23efd0fd.png" width="100%" height = "auto"></td>
  <td>This module used to communicate with android app. HC 05 works on serial communication. </td>
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

<h3>Materials</h3>
<table>
  <tr>
    <td><a href="https://www.kaggle.com/code/theeyeschico/crop-analysis-and-prediction">Crop analysis and prediction</a><td>
  </tr>
</table>