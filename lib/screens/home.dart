import 'dart:async';
import 'package:camera/camera.dart';
import 'package:connect_x_app/constants/components/snackbar_widget.dart';
import 'package:connect_x_app/constants/variables/shared.dart';
import 'package:connect_x_app/data/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool isLoading = false;

  @override
  void initState() {
    _controller = CameraController(
      const CameraDescription(
        sensorOrientation: 1,
        name: '1',
        lensDirection: CameraLensDirection.front,
      ),
      ResolutionPreset.high,
      enableAudio: false,
    );
    _initializeControllerFuture = _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<String> getData() {
    return Future.delayed(const Duration(seconds: 3), () {
      return "I am data";
    });
  }

  Future<void> combinedFuture() {
    return Future.wait([getData(), _initializeControllerFuture]);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
                child: FutureBuilder<void>(
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (isLoading) {
                        return Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: Colors.black,
                            size: 200,
                          ),
                        );
                      } else {
                        return CameraPreview(_controller);
                      }
                    } else {
                      return Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.black,
                          size: 200,
                        ),
                      );
                    }
                  }),
                  future: combinedFuture(),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Smile To Take A Sefie :)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: darkColor,
                fontFamily: regularFont,
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 1 / 12,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  try {
                    final image = await _controller.takePicture();
                    final capturedImagePath = image.path;
                    uploadImage(capturedImagePath, context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBarWidget.create('Saved successfully', true, 20),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBarWidget.create(
                          'Failed to save, try again', false, 20),
                    );
                  } finally {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    'Say Cheese!',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: regularFont,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
