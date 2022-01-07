import 'package:flutter/material.dart';
import 'package:americonictv_tv/logic/api/models/category_model.dart';
import 'package:americonictv_tv/ui/screens/feed/categories/bloc/selected_category_controller.dart';

class CategoryEntry extends StatefulWidget {
  final CategoryData category;
  final Function onTap;
  final String label;
  final int filter, index;

  CategoryEntry({
    this.category,
    this.onTap,
    this.label,
    this.filter,
    this.index,
  });

  @override
  State<StatefulWidget> createState() {
    return _CategoryEntryState();
  }
}

class _CategoryEntryState extends State<CategoryEntry> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        color: _isFocused ? Colors.white24 : Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: 40,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 0),
        child: Text(
          ( widget.category?.name?? widget.label).replaceAll('_', ' '),
          style: TextStyle(
            fontSize: widget.filter != null && widget.filter == widget.index
            ?20
            :null,
            fontWeight: widget.filter != null && widget.filter == widget.index
                ? FontWeight.bold
                : null,
            color: _isFocused ||
                    widget.filter != null && widget.filter == widget.index
                ? Colors.red
                : Colors.white70,
          ),
        ),
      ),
      onTap: () => widget.onTap != null
          ? widget.onTap()
          : SelectedCategoryController.change(widget.category.name),
      onFocusChange: (isFocused) => setState(() => _isFocused = isFocused),
    );
  }
}
