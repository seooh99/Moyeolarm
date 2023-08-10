import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:openvidu_client/openvidu_client.dart';
import 'package:youngjun/common/const/colors.dart';

import '../../common/button/btn_call.dart';
import 'drop_down.dart';
import 'media_stream_view.dart';

class ConfigView extends StatefulWidget {
  final LocalParticipant participant;
  final VoidCallback onConnect;
  const ConfigView({
    super.key,
    required this.onConnect,
    required this.participant,
  });

  @override
  State<ConfigView> createState() => _ConfigViewState();
}

class _ConfigViewState extends State<ConfigView> {

  List<MediaDevice>? _audioInputs;
  List<MediaDevice>? _audioOutputs;
  List<MediaDevice>? _videoInputs;
  MediaDevice? selectedAudioInput;
  MediaDevice? selectedVideoInput;

  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = Hardware.instance.onDeviceChange.stream
        .listen((List<MediaDevice> devices) {
      _loadDevices(devices);
    });
    Hardware.instance.enumerateDevices().then(_loadDevices);
  }

  void _loadDevices(List<MediaDevice> devices) async {
    _audioInputs = devices.where((d) => d.kind == 'audioinput').toList();
    _audioOutputs = devices.where((d) => d.kind == 'audiooutput').toList();
    _videoInputs = devices.where((d) => d.kind == 'videoinput').toList();
    selectedAudioInput = _audioInputs?.first;
    selectedVideoInput = _videoInputs?.first;
    setState(() {});
  }

  void _selectAudioInput(MediaDevice? device) async {
    if (device == null) return;
    if (kIsWeb) {
      widget.participant.setAudioInput(device.deviceId);
    } else {
      await Hardware.instance.selectAudioInput(device);
    }
    selectedAudioInput = device;
    setState(() {});
  }

  void _selectVideoInput(MediaDevice? device) async {
    if (device == null) return;
    if (selectedVideoInput?.deviceId != device.deviceId) {
      widget.participant.setVideoInput(device.deviceId);
      selectedVideoInput = device;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Widget _controlsWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 25),
          //   child: OVDropDown(
          //     label: 'Input',
          //     devices: _audioInputs ?? [],
          //     selectDevice: selectedAudioInput,
          //     onChanged: _selectAudioInput,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: OVDropDown(
              label: 'Video',
              devices: _videoInputs ?? [],
              selectDevice: selectedVideoInput,
              onChanged: _selectVideoInput,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 25),
          //   child: OVTextField(
          //     label: 'Secret',
          //     ctrl: _textSecretController,
          //   ),
          // ),
          BtnCalling(
              icons: Icon(Icons.call),
              onPressed: widget.onConnect,
          ),
        ],
      ),
    );
  }

  Widget _streamWidget() {
    return MediaStreamView(
      borderRadius: BorderRadius.circular(15),
      participant: widget.participant,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 80, left: 60, bottom: 30, right: 30),
                  child: _streamWidget(),
                ),
              ),
              Expanded(child: _controlsWidget()),
            ],
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 500,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 80, left: 30, bottom: 30, right: 30),
                    child: _streamWidget(),
                  ),
                ),
                _controlsWidget()
              ],
            ),
          );
        }
      }),
    );
  }
}
