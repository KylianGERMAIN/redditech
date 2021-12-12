# **Redditech**

## **Introduction**
### Redditech is an IT project in which we had to use the Reddit API (https://www.reddit.com/dev/api/) in order to build a mobile app.
&nbsp;
### For this reason we used some tools and language:
### - Dart SDK version : 2.13.1 (https://dart.dev/)
### - Flutter version : 2.2.1 (https://github.com/flutter/flutter.git)
### - HTML (HyperText Markup Langage)
### - Swift
### - Android Studio version : 2020.3.1 Patch 2 (https://developer.android.com/)
&nbsp;
***

## Table of contents
> * [Redditech](#redditech)
>   * [Introduction](#introduction)
>   * [Table of contents](#table-of-contents)
> * [User Documentation](#user-documentation)
>   * [How to install](#how-to-install)
>   * [Features](#features)
> * [Developer Documentation](#developer-documentation)
>   * [Back-End](#back-end)
>   * [Front-end](#ront-end)
&nbsp;

## **User Documentation**
***

### This part of the documentation is intended for users and will explain how to install the application and how to use it.
***

## **How to install**
***

### 1. Click on the application.
### 2. Click on the button "Login with Reddit"

<p align="center">
  <img src="https://raw.githubusercontent.com/AntoineVRG/ScreenForRedditech/main/login%20(copy).png" />
</p>

### 3. Put your Reddit ID (Name and Password)

### 4. Scroll down and accept the terms
<p align="center">
  <img src="https://raw.githubusercontent.com/AntoineVRG/ScreenForRedditech/main/permission.png" />
</p>
<p align="center">
  <img src="https://raw.githubusercontent.com/AntoineVRG/ScreenForRedditech/main/allow_or_decline.png" />
</p>

&nbsp;
### You are now on the application, I invite you to look at the different features of our application in the section **[Features](#features)** to understand the uses of the application
&nbsp;
***

## **Features**
***
&nbsp;

## **- Profile -**
### You will find different information there such as a description indicating the number of subscribers and a preference section which will allow you to know the multiple configurations that you have made on your Reddit account.
<p align="center">
  <img src="https://raw.githubusercontent.com/AntoineVRG/ScreenForRedditech/main/profile.png " />
</p>
&nbsp;

## **- New -**
### In the **New's** part you will find the new posts according to your preferences.
<p align="center">
  <img src="https://raw.githubusercontent.com/AntoineVRG/ScreenForRedditech/main/new_reddit.png " />
</p>
&nbsp;

## **- Popular -**
### In the ** Popular ** section you will find the most popular posts from Reddit.
<p align="center">
  <img src="https://raw.githubusercontent.com/AntoineVRG/ScreenForRedditech/main/popular_reddit.png " />
</p>
&nbsp;

## **- All -**
### In the **All** section you will find other contents.
<p align="center">
  <img src="https://raw.githubusercontent.com/AntoineVRG/ScreenForRedditech/main/all_reddit.png " />
</p>
&nbsp;

## **- Comment and Vote up -**
### You can also see below each post an up arrow (Vote top) and a chat bubble (Commentraire). It indicated the number of comments and Votes top that there were per post.
<p align="center">
  <img src="https://raw.githubusercontent.com/AntoineVRG/ScreenForRedditech/main/new_reddit.png " />
</p>
&nbsp;

## **Developer Documentation**
***

### This part of the documentation is for developers and will walk you through the most important parts of the code.

## **Installation / Configuration**
***

### To test our application on an emulator you will need to install **Flutter** and **Android Studio**. If you haven't already done so, I invite you to go to [Introduction](#introduction) and install the applications with the links.
***
&nbsp;

## **Back-End**
***
&nbsp;
## Get Some Data From API
```
getme() async {
    final response = await Dio().get(
      "https://oauth.reddit.com/api/v1/me",
      options: Options(headers: <String, dynamic>{
        'Authorization': 'Bearer $accessToken',
        'content-Type': 'application/x-www-form-urlencoded',
      }),
    );

    Map<dynamic, dynamic> result = response.data;
    Map<String, dynamic> data = Map<String, dynamic>();
    for (dynamic type in result.keys)
      data[type.toString()] = result[type];
}
```
&nbsp;
## WebView
```
Widget build(BuildContext context) {
    return Container(
    child: 
       WebView(
        initialUrl: 'https://www.reddit.com/api/v1/authorize.compact?client_id=$client_id&response_type=code&state=test&redirect_uri=$redirect_url&duration=permanent&scope=identity,edit,flair,history,modconfig,modflair,modlog,modposts,modwiki,mysubreddits,privatemessages,read,report,save,submit,subscribe,vote,wikiedit,wikiread',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          controller = controller;
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith("http://localhost")) {
            var pos = request.url.lastIndexOf('=');
            var code = (pos != -1)
                ? request.url.substring(pos + 1, request.url.length - 2)
                : request.url;
            postCode(code);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      )
    );
  }
```
&nbsp;
***
&nbsp;
## **Front-end**
***

&nbsp;
## Bottom Navigation Bar
```
BottomNavigationBar(
        backgroundColor: Colors.red[900],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'New',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Popular',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.all_out),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.portrait),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
        onTap: _onItemTapped,
      ),
```

## Display Information

### Example : 
```
static ProfileViewPicture(src) { ## Example : Function to display the user's picture
    return Container(
      child: ClipOval(
        child: Image.network(
            src,
            fit: BoxFit.fill,
            width: 256,
            height: 256,
        ),
      )
    );
  }
```
```
  static ProfileViewRender(name, subscriber, src, hidedowns, over_18, lang, videoAutoplay, hideAds, enableFollowers) { ## Main function to display in window
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 70.0),
            ProfileViewPicture(src), ## Call the function
            ## Call other functions
          ],
        )
      )
    );
  }
```

&nbsp;
***