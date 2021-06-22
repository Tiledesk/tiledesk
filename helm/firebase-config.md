
# Configure the Firebase Engine

Configure the required properties under the "Firebase Chat21 Engine" section of the values.yaml. You can find more info about creating Firebase Project and configure it here: 
* [Chat21 Firebase Installation](https://developer.tiledesk.com/installation/chat21-installation/chat21-firebase-installation)
* [Chat21 Channel Configuration](https://developer.tiledesk.com/configuration/channel)

Example: 
```
CHAT21_ENGINE: firebase
CHAT21_URL: https://CHANGEIT.cloudfunctions.net
CHAT21_ADMIN_TOKEN: CHANGEIT
FIREBASE_PRIVATE_KEY: CHANGEIT
FIREBASE_CLIENT_EMAIL: CHANGEIT
FIREBASE_PROJECT_ID: CHANGEIT
FIREBASE_APIKEY: CHANGEIT
FIREBASE_AUTHDOMAIN: CHANGEIT.firebaseapp.com
FIREBASE_DATABASEURL: https://CHANGEIT.firebaseio.com
FIREBASE_STORAGEBUCKET: CHANGEIT.appspot.com
FIREBASE_MESSAGINGSENDERID: CHANGEIT
FIREBASE_APP_ID: CHANGEIT
```


# Configure the Chat21 webhooks

[Configure the Chat21 webhooks](https://developer.tiledesk.com/installation/chat21-installation/chat21-firebase-installation#2-2-configure-the-chat21-webhooks) to point to the new Kubernetes tiledesk-server endpoint (tiledesk-server service hostname or ip)
If you want to expose your local Tiledesk-server component to internet you can find usefull info [here](https://itnext.io/expose-local-kubernetes-service-on-internet-using-ngrok-2888a1118b5b).


## Install the Chart passing inline parameters

To install the `my-tiledesk` deployment passing the parameters inline without modifing the value.yaml file:

```console
helm install helm --set CHAT21_URL=https://CHANGE_IT.cloudfunctions.net --set FIREBASE_CLIENT_EMAIL=firebase-adminsdk-CHANGE_IT@CHANGE_IT.iam.gserviceaccount.com --set FIREBASE_PROJECT_ID=CHANGE_IT --set FIREBASE_APIKEY=CHANGE_IT --set FIREBASE_AUTHDOMAIN=CHANGE_IT.firebaseapp.com --set FIREBASE_DATABASEURL=https://CHANGE_IT.firebaseio.com --set FIREBASE_STORAGEBUCKET=CHANGE_IT.appspot.com --set FIREBASE_MESSAGINGSENDERID=CHANGE_IT --set FIREBASE_APP_ID=CHANGEIT 
```