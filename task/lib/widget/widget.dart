import 'package:task/config/screen_config.dart';
import 'package:task/config/themes/light_theme.dart';
import 'package:flutter/material.dart';

/// This class is used to make the primary buttons in the application.
/// Button type: Raised button with text and icon button with text.
/// Required parameters: Text, callback when the button is pressed.
class AppElevatedButton extends StatelessWidget {
  final IconData? icon;
  final String? message;
  final VoidCallback? onPressed;
  final double? borderRadius;
  final Color? color;
  final double? minWidth;
  final Color? textColor;
  final Widget? leadingWidget;
  final TextStyle? textStyle;

  const AppElevatedButton({
    required this.message,
    required this.onPressed,
    Key? key,
    this.icon,
    this.borderRadius,
    this.minWidth,
    this.color,
    this.textColor,
    this.leadingWidget,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildRaisedButton(context);
  }

  Widget _buildRaisedButton(BuildContext context) {
    return ButtonTheme(
      minWidth: minWidth ?? AppScreenConfig.getScreenWidth()! * 0.4,
      height: 40.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          ),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: minWidth ?? AppScreenConfig.getScreenWidth()! * 0.4,
              minHeight: 40.0,
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: (message?.isNotEmpty ?? false)
                  ? (icon == null && leadingWidget == null)
                      ? _getButtonWithTextOnly(message!, context)
                      : (leadingWidget == null)
                          ? _getButtonWithIconText(icon, message!, context)
                          : _getButtonWithLeadingText(
                              leadingWidget!, message!, context)
                  : Container(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getButtonWithIconText(
      IconData? icon, String message, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: LightAppColors.primaryButtonTextColor),
        const SizedBox(
          height: 0.0,
          width: 12.0,
        ),
        Flexible(
          child: Text(
            message.toUpperCase(),
            textAlign: TextAlign.center,
            style: color == null
                ? TextStyle(color: LightAppColors.primaryButtonTextColor)
                : (Theme.of(context).brightness == Brightness.light)
                    ? TextStyle(color: LightAppColors.primaryButtonTextColor)
                    : TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }

  Widget _getButtonWithTextOnly(String message, BuildContext context) {
    return Text(
      message.toUpperCase(),
      textAlign: TextAlign.center,
      style: getTextStyle(context),
    );
  }

  TextStyle? getTextStyle(BuildContext context) {
    if (textStyle != null) {
      return textStyle;
    } else if (textColor == null) {
      return color == null
          ? TextStyle(color: LightAppColors.primaryButtonTextColor)
          : (Theme.of(context).brightness == Brightness.light)
              ? TextStyle(color: LightAppColors.primaryButtonTextColor)
              : TextStyle(color: Theme.of(context).primaryColor);
    } else {
      return TextStyle(color: textColor);
    }
  }

  Widget _getButtonWithLeadingText(
      Widget leading, String message, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        leading,
        const SizedBox(
          height: 0.0,
          width: 12.0,
        ),
        Flexible(
          child: Text(
            message.toUpperCase(),
            textAlign: TextAlign.center,
            style: color == null
                ? TextStyle(color: LightAppColors.primaryButtonTextColor)
                : (Theme.of(context).brightness == Brightness.light)
                    ? TextStyle(color: LightAppColors.primaryButtonTextColor)
                    : TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}

class AppTextButton extends StatelessWidget {
  final String message;
  final VoidCallback? onPressed;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final double? maxWidth;

  const AppTextButton({
    required this.message,
    required this.onPressed,
    Key? key,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget flatButton;
    if (icon == null) {
      flatButton = TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          primary:
              (backgroundColor != null) ? backgroundColor : Colors.transparent,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth ?? AppScreenConfig.screenWidth / 2,
          ),
          child: Text(message.toString(),
              textAlign: TextAlign.center,
              style: (textStyle != null)
                  ? textStyle
                  : (textColor != null)
                      ? Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(color: textColor)
                      : Theme.of(context).textTheme.button),
        ),
      );
    } else if ((icon != null) && (message.isNotEmpty)) {
      flatButton = TextButton.icon(
        onPressed: onPressed,
        icon: icon!,
        label: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth ?? AppScreenConfig.screenWidth / 2,
          ),
          child: Text(message,
              style: (textStyle != null)
                  ? textStyle
                  : (textColor != null)
                      ? Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(color: textColor)
                      : Theme.of(context).textTheme.button),
        ),
      );
    } else {
      flatButton = Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          icon!,
          Text(
            message,
            style: (textStyle != null)
                ? textStyle
                : (textColor != null)
                    ? Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: textColor)
                    : Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: Theme.of(context).primaryColor),
          )
        ],
      );
    }
    return flatButton;
  }
}

class AppOutlinedButton extends StatelessWidget {
  final String? message;
  final VoidCallback onPressed;
  final Color? borderAndTextColor;
  final Widget? icon;
  final EdgeInsetsGeometry? padding;

  const AppOutlinedButton({
    required this.message,
    required this.onPressed,
    Key? key,
    this.borderAndTextColor,
    this.icon,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: padding ??
            const EdgeInsets.symmetric(
                vertical: AppSpacing.xs, horizontal: AppSpacing.m),
        side: BorderSide(
            width: 0.9,
            color: (borderAndTextColor != null)
                ? borderAndTextColor!
                : Theme.of(context).primaryColor //Color of the border
            ),
      ),
      onPressed: onPressed,
      child: (icon != null)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                icon!,
                const SizedBox(height: 0.0, width: 12.0),
                Flexible(
                  child: _getOutlineButtonText(context),
                ),
              ],
            )
          : _getOutlineButtonText(context),
    );
  }

  Widget _getOutlineButtonText(BuildContext context) {
    return Text(
      message!.toUpperCase(),
      style: (borderAndTextColor != null)
          ? Theme.of(context)
              .textTheme
              .button!
              .copyWith(color: borderAndTextColor)
          : Theme.of(context)
              .textTheme
              .button!
              .copyWith(color: Theme.of(context).primaryColor),
      textAlign: TextAlign.center,
    );
  }
}

class AppCircularProgressLoader extends StatelessWidget {
  final double strokeWidth;
  final Color? strokeColor;

  const AppCircularProgressLoader({this.strokeWidth = 4.0, this.strokeColor});

  @override
  Widget build(BuildContext context) {
    return _buildCircularProgressLoader(context);
  }

  Widget _buildCircularProgressLoader(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: strokeWidth,
      valueColor: (strokeColor != null)
          ? AlwaysStoppedAnimation<Color?>(strokeColor)
          : AlwaysStoppedAnimation<Color>(LightAppColors.bannerColorLight),
    );
  }
}

class AppIconButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onPressed;
  final Color? iconColor;
  final bool addCircularBackground;
  final Color circularBackgroundColor;
  final Color? materialBackgroundColor;
  final bool addCircularBorderToMaterial;
  final String? tooltip;
  final double? iconSize;
  final bool removeTagertExtraPadding;
  final BoxConstraints? constraints;

  const AppIconButton({
    required this.icon,
    required this.onPressed,
    Key? key,
    this.iconColor,
    this.addCircularBackground = false,
    this.circularBackgroundColor = Colors.transparent,
    this.materialBackgroundColor,
    this.addCircularBorderToMaterial = false,
    this.tooltip,
    this.iconSize,
    this.removeTagertExtraPadding = false,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return _buildIconButton(context);
  }

  Widget _buildIconButton(BuildContext context) {
    return Material(
      color: materialBackgroundColor ?? Colors.transparent,
      shape: (addCircularBorderToMaterial)
          ? const RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(6.0),
              ),
            )
          : null,
      child: Ink(
        decoration: (addCircularBackground) ? _getCircularDecoration() : null,
        child: (removeTagertExtraPadding)
            ? Container(
                width: iconSize != null ? iconSize! * 1.5 : 36.0,
                padding: const EdgeInsets.all(0.0),
                child: _displayIconButton(context),
              )
            : _displayIconButton(context),
      ),
    );
  }

  ShapeDecoration _getCircularDecoration() {
    return ShapeDecoration(
      shape: const CircleBorder(),
      color: circularBackgroundColor,
    );
  }

  IconButton _displayIconButton(BuildContext context) {
    return IconButton(
      iconSize: iconSize ?? 24.0,
      padding: removeTagertExtraPadding
          ? const EdgeInsets.all(0.0)
          : const EdgeInsets.all(8.0),
      constraints: constraints ?? const BoxConstraints(),
      icon: Icon(icon),
      onPressed: onPressed,
      color: iconColor ?? Theme.of(context).primaryColor,
      disabledColor: LightAppColors.inactiveActionColor,
      tooltip: tooltip,
    );
  }
}

class AppTextIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? iconColor;
  final bool addCircularBackground;
  final Color? circularBackgroundColor;
  final String? tooltip;
  final double? iconSize;
  final String? text;
  final Color? textColor;

  const AppTextIconButton({
    required this.icon,
    required this.onPressed,
    Key? key,
    this.iconColor,
    this.addCircularBackground = false,
    this.circularBackgroundColor,
    this.tooltip,
    this.iconSize,
    this.text,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return _buildTextIconButton(context);
  }

  Widget _buildTextIconButton(BuildContext context) {
    return Ink(
      decoration: (addCircularBackground) ? _getCircularDecoration() : null,
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor ?? Theme.of(context).primaryColor,
              size: iconSize ?? 20,
            ),
            Text(
              '$text',
              style: Theme.of(context).textTheme.overline!.copyWith(
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold,
                    color: textColor ??
                        Theme.of(context).textTheme.bodyText1 as Color?,
                  ),
            )
          ],
        ),
      ),
    );
  }

  ShapeDecoration _getCircularDecoration() {
    return ShapeDecoration(
      shape: const CircleBorder(),
      color: circularBackgroundColor,
    );
  }
}
