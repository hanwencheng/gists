# Use Google Speech Recognition in Unity

## Prequisites
* Unity 2019.2 or any version support .NET 4.x scripting runtime, 
and following [microSoft Guide](https://docs.microsoft.com/en-us/visualstudio/cross-platform/unity-scripting-upgrade?view=vs-2019)
to enable it.
* npm and node installed.
* Create google service account and add GOOGLE_APPLICATION_CRENDENTIALS to path with the [guide here](https://cloud.google.com/docs/authentication/getting-started)
* Enable speech-to-text API (and natural-language API if needed) in your google cloud console -> APIs and Services -> Dashboard -> Enable APIS and Services.

## Create a server to recognize the speech.
1. Use any of your favorite programming languages to generate a speech recognition server with 
[google API](https://cloud.google.com/speech-to-text/docs/streaming-recognize#speech-streaming-recognize-nodejs).
2. Set up a websocket server, and use websocket to send the recognition result to client side.
Here we use [websocket](https://github.com/websockets/ws) on node.js, which is very simple to integrate.

## Set up client side on Unity to receive recognition result.
1. Integrate this [nativeWebsocket](https://github.com/endel/NativeWebSocket) library on C# to Unity:
Copy the files in `NativeWebSocket/NativeWebSocket/Assets/` to `Assets` folder in Unity.
2. Create a simple empty object in Unity, and attach a script to it. 
Fill the script with client side code for receiving the result, you can refer to the example in the Assets folder,
or use this one:

```C#
using System;
using NativeWebSocket;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VoiceController : MonoBehaviour
{
    // Start is called before the first frame update
    WebSocket websocket;
    async void Start()
    {
        websocket = new WebSocket("ws://localhost:1337");


        websocket.OnOpen += () =>
        {
            Debug.Log("Connected!");
            websocket.SendText("Connect Request");
        };
        websocket.OnMessage += (bytes) =>
        {
            var message = System.Text.Encoding.UTF8.GetString(bytes);
            Debug.Log("OnMessage! " + message);
        };
        websocket.OnError += (e) =>
        {
            Debug.Log("Error! " + e);
        };

        websocket.OnClose += (e) =>
        {
            Debug.Log("Connection closed!");
        };
        await websocket.Connect();
    }

    // Update is called once per frame
    void Update()
    {}
    private async void OnApplicationQuit()
    {
        await websocket.Close();
    }
}
```

## Start the server and client!
Then setting up is finished. First start your websocket server (in node), and then start the unity application.
Now it should log out what ever you said!
