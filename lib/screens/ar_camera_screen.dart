import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ARCameraScreen extends StatefulWidget {
  final String modelPath;
  final String modelName;

  const ARCameraScreen({
    super.key,
    required this.modelPath,
    required this.modelName,
  });

  @override
  State<ARCameraScreen> createState() => _ARCameraScreenState();
}

class _ARCameraScreenState extends State<ARCameraScreen> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool _showModel = false;
  double _modelScale = 1.0;
  double _modelRotationY = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        _cameraController = CameraController(
          cameras.first,
          ResolutionPreset.high,
          enableAudio: false,
        );

        await _cameraController!.initialize();

        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
          });
        }
      }
    } catch (e) {
      debugPrint('Error inicializando cámara: $e');
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  void _toggleModel() {
    setState(() {
      _showModel = !_showModel;
    });
  }

  void _resetModel() {
    setState(() {
      _modelScale = 1.0;
      _modelRotationY = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Vista de la cámara
          if (_isCameraInitialized && _cameraController != null)
            Positioned.fill(
              child: CameraPreview(_cameraController!),
            )
          else
            const Positioned.fill(
              child: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),

          // Overlay del modelo 3D
          if (_showModel)
            Positioned(
              top: MediaQuery.of(context).size.height * 0.3,
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              bottom: MediaQuery.of(context).size.height * 0.3,
              child: Transform.scale(
                scale: _modelScale,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(_modelRotationY),
                  child: ModelViewer(
                    backgroundColor: Colors.transparent,
                    src: widget.modelPath,
                    alt: widget.modelName,
                    ar: false,
                    autoRotate: false,
                    disableZoom: false,
                    cameraControls: true,
                  ),
                ),
              ),
            ),

          // Controles superiores
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.modelName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Controles inferiores
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Controles de escala y rotación
                      if (_showModel) ...[
                        Row(
                          children: [
                            const Icon(Icons.zoom_out, color: Colors.white),
                            Expanded(
                              child: Slider(
                                value: _modelScale,
                                min: 0.5,
                                max: 2.0,
                                divisions: 15,
                                activeColor: Colors.blue,
                                inactiveColor: Colors.white.withOpacity(0.3),
                                onChanged: (value) {
                                  setState(() {
                                    _modelScale = value;
                                  });
                                },
                              ),
                            ),
                            const Icon(Icons.zoom_in, color: Colors.white),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.rotate_left, color: Colors.white),
                            Expanded(
                              child: Slider(
                                value: _modelRotationY,
                                min: -3.14159,
                                max: 3.14159,
                                divisions: 20,
                                activeColor: Colors.green,
                                inactiveColor: Colors.white.withOpacity(0.3),
                                onChanged: (value) {
                                  setState(() {
                                    _modelRotationY = value;
                                  });
                                },
                              ),
                            ),
                            const Icon(Icons.rotate_right, color: Colors.white),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Botones principales
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Botón para mostrar/ocultar modelo
                          FloatingActionButton(
                            onPressed: _toggleModel,
                            backgroundColor:
                                _showModel ? Colors.red : Colors.blue,
                            child: Icon(
                              _showModel
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                          ),

                          // Botón para resetear modelo
                          if (_showModel)
                            FloatingActionButton(
                              onPressed: _resetModel,
                              backgroundColor: Colors.orange,
                              child: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    ],
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
