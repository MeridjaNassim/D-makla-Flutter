import 'package:flutter/material.dart' as material;

class App {
  material.BuildContext _context;
  double _height;
  double _width;
  double _heightPadding;
  double _widthPadding;

  App(_context) {
    this._context = _context;
    material.MediaQueryData _queryData = material.MediaQuery.of(this._context);
    _height = _queryData.size.height / 100.0;
    _width = _queryData.size.width / 100.0;
    _heightPadding = _height - ((_queryData.padding.top + _queryData.padding.bottom) / 100.0);
    _widthPadding = _width - (_queryData.padding.left + _queryData.padding.right) / 100.0;
  }

  double appHeight(double v) {
    return _height * v;
  }

  double appWidth(double v) {
    return _width * v;
  }

  double appVerticalPadding(double v) {
    return _heightPadding * v;
  }

  double appHorizontalPadding(double v) {
    return _widthPadding * v;
  }
}

class Colors {
//  Color _mainColor = Color(0xFFFF4E6A);
  material.Color _mainColor = material.Colors.pink;
  material.Color _mainDarkColor = material.Colors.pink;
  material.Color _secondColor = material.Color(0xFF344968);
  material.Color _secondDarkColor = material.Color(0xFFccccdd);
  material.Color _accentColor = material.Color(0xFF8C98A8);
  material.Color _accentDarkColor = material.Color(0xFF9999aa);

  material.Color mainColor(double opacity) {
    return this._mainColor.withOpacity(opacity);
  }

  material.Color secondColor(double opacity) {
    return this._secondColor.withOpacity(opacity);
  }

  material.Color accentColor(double opacity) {
    return this._accentColor.withOpacity(opacity);
  }

  material.Color mainDarkColor(double opacity) {
    return this._mainDarkColor.withOpacity(opacity);
  }

  material.Color secondDarkColor(double opacity) {
    return this._secondDarkColor.withOpacity(opacity);
  }

  material.Color accentDarkColor(double opacity) {
    return this._accentDarkColor.withOpacity(opacity);
  }
}
