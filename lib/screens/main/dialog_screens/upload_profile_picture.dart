import 'package:flutter/material.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/dialog_header.dart';

class UploadProfilePicture extends StatefulWidget {
  const UploadProfilePicture({super.key, required this.image});

  final dynamic image;

  @override
  State<UploadProfilePicture> createState() => _UploadProfilePictureState();
}

class _UploadProfilePictureState extends State<UploadProfilePicture>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;

  late Animation<double> _animation1;
  late Animation<double> _animation2;

  @override
  void initState() {
    _controller1 =
        AnimationController(vsync: this, duration: kAnimationDuration1);

    _controller2 =
        AnimationController(vsync: this, duration: kAnimationDuration1);

    _controller1.forward().whenCompleteOrCancel(() {
      _controller2.forward();
    });

    _animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(_controller1);
    _animation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller2, curve: Curves.easeIn),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DialogHeader(
          headerText: 'Add Picture',
          icon: Icons.upload_file,
          mainColor: kYellowColor,
        ),

        const SizedBox(height: 10.0),

        // imege from file
        Container(
          child: widget.image != null
              ? Image(
                  image: widget.image!,
                  fit: BoxFit.contain,
                  opacity: _animation1,
                  width: double.infinity,
                  height: 250.0,
                )
              : Center(
                  child: Text('No image selected', style: kGreyNormalTextStyle(context)),
                ),
        ),

        const SizedBox(height: 20.0),

        // upload button
        FadeTransition(
          opacity: _animation2,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Button(
                  buttonText: 'Set Picture',
                  onPressed: () {
                    // TODO: Implement Upload Functionality
                  },
                  buttonColor: kYellowColor,
                  inactive: false,
                ),
              ),
              const SizedBox(width: 5.0),
              Expanded(
                child: ButtonIcon(
                  buttonText: '',
                  onPressed: () {
                    navigatorPop(context);
                  },
                  buttonColor: kRedColor,
                  icon: Icons.close,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
