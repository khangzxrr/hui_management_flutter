importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
    apiKey: "AIzaSyD5ZwjqnHzX9LjiUu1SrFtfZE_sdXXlFPk",
    authDomain: "test-1d90e.firebaseapp.com",
    projectId: "test-1d90e",
    storageBucket: "test-1d90e.appspot.com",
    messagingSenderId: "976834930137",
    appId: "1:976834930137:web:f65a73bb39c0a1ff15e5c8",
    measurementId: "G-W2J4MQP39F"
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});
