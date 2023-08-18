import 'package:flutter/material.dart';
import 'package:openvidu_client/openvidu_client.dart';
import 'package:moyeolam/web_rtc/model/alarm_group_member.dart';

import 'future_wrapper.dart';
import 'no_video.dart';

class MediaStreamView extends StatefulWidget {
  final bool mirror;
  final Participant? participant;
  final BorderRadiusGeometry? borderRadius;
  final String? userName;
  final MemberState? memberState;

  const MediaStreamView({
    super.key,
    this.participant,
    this.mirror = false,
    this.borderRadius,
    this.userName,
    this.memberState,
  });

  @override
  State<MediaStreamView> createState() => _MediaStreamViewState();
}

class _MediaStreamViewState extends State<MediaStreamView> {
  late RTCVideoRenderer _render;

  void setOutput() {}

  @override
  void initState() {
    super.initState();
    _render = RTCVideoRenderer();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.participant == null) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: widget.borderRadius,
          border: Border.all(color: Colors.grey),
        ),
        child: Stack(
          children: [
            if (widget.userName != null)
              Container(
                color: Colors.black.withOpacity(0.3),
                padding: const EdgeInsets.symmetric(
                  vertical: 7,
                  horizontal: 10,
                ),
                child: Text(widget.userName ?? '',
                    style: const TextStyle(color: Colors.white)),
              ),
            if (widget.memberState != null)
              Container(
                color: Colors.black.withOpacity(0.3),
                margin: const EdgeInsets.symmetric(
                  vertical: 30,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 7,
                  horizontal: 10,
                ),
                child: Text(widget.memberState?.code ?? '',
                    style: const TextStyle(color: Colors.white)),
              ),
          ],
        ),
      );
    } else {
      return FutureWrapper(
        future: _render.initialize(),
        builder: (context) {
          _render.srcObject = widget.participant!.stream;
          return Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: widget.borderRadius,
              border: Border.all(color: Colors.grey),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                (widget.participant!.videoActive)
                    ? RTCVideoView(
                        _render,
                        objectFit:
                            RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                        mirror: widget.mirror,
                      )
                    : const NoVideoWidget(),
                if (widget.userName != null)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    padding: const EdgeInsets.symmetric(
                      vertical: 7,
                      horizontal: 10,
                    ),
                    child: Text(widget.userName ?? '',
                        style: const TextStyle(color: Colors.white)),
                  ),
                if (widget.memberState != null)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    margin: const EdgeInsets.symmetric(
                      vertical: 30,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 7,
                      horizontal: 10,
                    ),
                    child: Text(widget.memberState?.code ?? '',
                        style: const TextStyle(color: Colors.white)),
                  ),
              ],
            ),
          );
        },
      );
    }
  }
}
