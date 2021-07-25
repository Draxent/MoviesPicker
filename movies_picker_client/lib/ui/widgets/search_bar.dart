import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data/models/language.dart';
import '../../data/models/location.dart';
import '../../data/models/movie_details.dart';
import '../../logic/search_criteria_provider.dart';
import '../../shared/shared.dart';

class SearchBarController extends StatelessWidget {
  const SearchBarController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchCriteriaProvider>();
    return SearchBarViewer(provider);
  }
}

class SearchBarViewer extends StatefulWidget {
  const SearchBarViewer(this.provider);

  final SearchCriteriaProvider provider;

  @override
  _SearchBarViewerState createState() => _SearchBarViewerState();
}

class _SearchBarViewerState extends State<SearchBarViewer> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    if (widget.provider.title != null) {
      textEditingController.text = widget.provider.title!;
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.appBarTheme.textTheme!.headline6!;
    final bgColor = theme.primaryColor;
    return Row(children: [
      const Icon(FontAwesomeIcons.search),
      Expanded(
        child: _buildSearch(textStyle),
      ),
      SharedWidgets.hSpace,
      _buildDropdownLanguage(bgColor, textStyle),
      SharedWidgets.hSpace,
      _buildDropdownLocation(bgColor, textStyle),
      SharedWidgets.hSpace,
      _buildClearButton(),
    ]);
  }

  Widget _buildDropdownLanguage(Color bgColor, TextStyle textStyle) =>
      DropdownButton<Language>(
        hint: Text(MovieDetails.strLanguage, style: textStyle.italic),
        value: widget.provider.language,
        onChanged: (val) => widget.provider.changeLanguage(val),
        style: textStyle,
        dropdownColor: bgColor,
        items: Language.values
            .map((x) =>
                DropdownMenuItem<Language>(value: x, child: Text(x.display)))
            .toList(growable: false),
      );

  Widget _buildDropdownLocation(Color bgColor, TextStyle textStyle) =>
      DropdownButton<Location>(
        hint: Text(MovieDetails.strLocation, style: textStyle.italic),
        value: widget.provider.location,
        onChanged: (val) => widget.provider.changeLocation(val),
        style: textStyle,
        dropdownColor: bgColor,
        items: Location.values
            .map((x) =>
                DropdownMenuItem<Location>(value: x, child: Text(x.display)))
            .toList(growable: false),
      );

  Widget _buildSearch(TextStyle textStyle) => TextFormField(
        controller: textEditingController,
        onEditingComplete: () =>
            widget.provider.changeTitle(textEditingController.value.text),
        style: textStyle,
        decoration: InputDecoration(
          hintText: 'Search',
          border: const OutlineInputBorder(),
          hintStyle: textStyle.italic,
        ),
      );

  Widget _buildClearButton() => IconButton(
        onPressed: () => widget.provider.clear(),
        tooltip: 'Clear',
        icon: const Icon(FontAwesomeIcons.times),
      );
}
