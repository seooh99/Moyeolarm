import 'package:flutter/material.dart';
import 'package:openvidu_client/openvidu_client.dart';
import 'package:youngjun/common/const/colors.dart';

class OVDropDown extends StatelessWidget {
  final String label;
  final MediaDevice? selectDevice;
  final List<MediaDevice> devices;
  final ValueChanged<MediaDevice?>? onChanged;

  const OVDropDown(
      {super.key,
      required this.label,
      this.devices = const [],
      this.selectDevice,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.white.withOpacity(.3),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonFormField<MediaDevice>(
              isExpanded: true,
              dropdownColor: BACKGROUND_COLOR,
              items: devices
                  .map(
                    (device) => DropdownMenuItem(
                      value: device,
                      child: ListTile(
                        title: Text(
                          device.label,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
              value: selectDevice,
              decoration: const InputDecoration(
                isCollapsed: true,
                prefixIcon: Icon(
                  Icons.videocam,
                  color: Colors.white,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 0,
                ),
              ),
            )),
      ],
    );
  }
}
