import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../core/di/di.dart';
import '../../../../core/widgets/alerts.dart';
import '../../../../core/widgets/app_bar.dart';
import '../cubits/detection/detection_cubit.dart';
import '../widgets/dialogs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _imageHandler = BehaviorSubject<String>.seeded('');
  final _detectionCubit = getIt<DetectionCubit>();

  @override
  void dispose() {
    _imageHandler.close();
    _detectionCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar().build(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildImagePreview(),
            const SizedBox(height: 20),
            _buildActionButtons(),
            const SizedBox(height: 20),
            _buildDivider(),
            const SizedBox(height: 20),
            _showPredictionResult(),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    return StreamBuilder<String>(
      stream: _imageHandler.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Container(
            margin: const EdgeInsets.only(top: 20.0),
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.file(File(snapshot.data!), fit: BoxFit.cover),
            ),
          );
        }
        return const Text('No image selected');
      },
    );
  }

  Widget _buildActionButtons() {
    return StreamBuilder<String>(
      stream: _imageHandler.stream,
      builder: (context, snapshot) {
        final hasImage = snapshot.hasData && snapshot.data!.isNotEmpty;

        return Column(
          children: [
            ElevatedButton.icon(
              onPressed: _handleImageSelection,
              icon: Icon(hasImage ? Icons.calculate : Icons.camera_alt),
              label: Text(hasImage ? "Detect diseases" : "Take an Image"),
            ),
            if (hasImage) ...[
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _resetImage,
                icon: const Icon(Icons.delete),
                label: const Text("Clear"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildDivider() {
    return Divider(thickness: 2, color: Theme.of(context).colorScheme.primary);
  }

  Future<void> _handleImageSelection() async {
    if (!_imageHandler.hasValue || _imageHandler.value.isEmpty) {
      try {
        final String? imagePath = await ImagePickerDialog.showAlertDialog(
          context: context,
          title: "Select Image",
          content: "Select an image from the camera or gallery",
        );

        if (imagePath != null && imagePath.isNotEmpty) {
          _imageHandler.add(imagePath);
        } else {
          _showError("No image selected");
        }
      } catch (e) {
        _showError("Error selecting image: ${e.toString()}");
      }
    } else {
      await _detectDiseases(_imageHandler.value!);
    }
  }

  Future<void> _detectDiseases(String imagePath) async {
    try {
      // TODO: Implement disease detection API call
      _detectionCubit.startDetection(imagePath);
    } catch (e) {
      _showError("Error detecting diseases: ${e.toString()}");
    }
  }

  void _showError(String message) {
    AppAlerts.showSnackBar(context: context, message: message, isError: true);
  }

  void _resetImage() {
    _detectionCubit.resetDetection();
    _imageHandler.add('');
  }

  _showPredictionResult() {
    return BlocConsumer<DetectionCubit, DetectionState>(
      bloc: _detectionCubit,
      listener: (context, state) {
        if (state is DetectionError) {
          _showError(state.message);
        }
      },
      builder: (context, state) {
        if (state is DetectionLoading) {
          return CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          );
        } else if (state is DetectionSuccess) {
          return _showResult(context, state);
        }
        return const SizedBox.shrink();
      },
    );
  }

  GestureDetector _showResult(BuildContext context, DetectionSuccess state) {
    return GestureDetector(
      onTap: () {
        //TODO: Implement navigation to details screen
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "Predicted result: ${state.className}",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
