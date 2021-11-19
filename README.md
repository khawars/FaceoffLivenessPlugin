
# LivelinessPlugin

This is a cordova iOS plugin for Liveness SDK.

### Installation

To add this plugin to your project, follow these steps:

1. Open a command prompt or terminal window.
2. Change directories to the root of your Cordova project.
3. Run the following command to add the plugin to your Cordova project:
    ``` $ cordova plugin add <path to plugin folder> ```
4. Run the following command to build your Cordova project:
    ``` $ cordova build ```


### Example:
Call ``checkLiveness`` method of plugin using following parameters

```cordova.exec(success, null, "FaceoffLivenessPlugin", "checkLiveness", ["Base64 representation of Front cnic image", "Base64 representation of Back cnic image", true, true, true, true, true, 3]);```

#### Parameters Description:

| Data Type | Description                               |
|-----------|-------------------------------------------|
| String    | Base64 representation of Front cnic image |
| String    | Base64 representation of Back cnic image  |
| Bool      | Set challenge to move face to right       |
| Bool      | Set challenge to move face to left        |
| Bool      | Set challenge to nod head                 |
| Bool      | Is face comparison required               |
| Bool      | Is OCR required                           |
| Int       | Max number of challenges                  |



### Response:
Response will be in the form of JSON string. Which contains faceImageData and json objects of OcrResponse, FaceComparisonResponse.

```
function success(result) {
    print(result);
};
````

