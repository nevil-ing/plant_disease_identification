import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

import '../hive_data/disease_info_data.dart';
import '../path/path.dart';
import '../util/label_detector_paint.dart';
import '../vision_detector/detector_view.dart';

class MaizeDisease extends StatefulWidget {
  @override
  State<MaizeDisease> createState() => _MaizeDiseaseState();
}

class _MaizeDiseaseState extends State<MaizeDisease> {
  late ImageLabeler _imageLabeler;
  bool _canProcess = false;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  String? _diseaseType;
  late bool isLoading;
// Generation Configuration

  //store hive data in a variable
  List myMaizeRustData = [];

//to update the data from hive in variable
  getRustHiveData() {
    myMaizeRustData = HiveFunctions.getMaizeRustData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initializeLabeler();
    getRustHiveData();
  }

  @override
  void dispose() {
    _canProcess = false;
    _imageLabeler.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KijaniTunza'),
        centerTitle: true,
      ),
      drawer: const Drawer(
        child: SingleChildScrollView(),
      ),
      body: DetectorView(
        title: 'Maize Disease Identification',
        customPaint: _customPaint,
        text: _text,
        onImage: _processImage,
      ),
    );
  }

  void _initializeLabeler() async {
    // uncomment next line if you want to use the default model
    // _imageLabeler = ImageLabeler(options: ImageLabelerOptions());

    // uncomment next lines if you want to use a local model
    // make sure to add tflite model to assets/ml
    // final path = 'assets/ml/lite-model_aiy_vision_classifier_birds_V1_3.tflite';
    // final path = 'assets/ml/object_labeler_flowers.tflite';
    const path = 'assets/models/1.tflite';
    final modelPath = await getAssetPath(path);
    final options = LocalLabelerOptions(modelPath: modelPath);
    _imageLabeler = ImageLabeler(options: options);

    // uncomment next lines if you want to use a remote model
    // make sure to add model to firebase
    // final modelName = 'bird-classifier';
    // final response =
    //     await FirebaseImageLabelerModelManager().downloadModel(modelName);
    // print('Downloaded: $response');
    // final options =
    //     FirebaseLabelerOption(confidenceThreshold: 0.5, modelName: modelName);
    // _imageLabeler = ImageLabeler(options: options);

    _canProcess = true;
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    setState(() {
      isLoading = true;
    });
    // String _text = '';
    final labels = await _imageLabeler.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = LabelDetectorPainter(labels);
      _customPaint = CustomPaint(painter: painter);
    } else {
      String text = 'Labels found: ${labels.length}\n\n';
      for (final label in labels) {
        // Replace 'disease_name'

        final disease = label.label;
        setState(() {
          _diseaseType = disease;
        });

        showModalBottomSheet(
          //anchorPoint: Offset.zero,
          showDragHandle: true,
          enableDrag: true,
          isScrollControlled: true,

          context: context,
          builder: (BuildContext context) {
            return DraggableScrollableSheet(
              shouldCloseOnMinExtent: false,
              initialChildSize: 0.3,
              expand: false,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                );
              },
            );
          },
        );
      }
      print("Disease Found: $labels");
      print("Final Text: $_text");
      _text = text;
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
