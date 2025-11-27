import 'package:flutter/material.dart';

@immutable
class AppIcons {
  final Map<String, dynamic> _iconConfigs;

  const AppIcons._(this._iconConfigs);

  factory AppIcons.fromJson(Map<String, dynamic> json) {
    final defaults = {
      'back': 'arrow_back',
      'close': 'close',
      'menu': 'menu',
      'search': 'search',
      'home': 'home',
      'settings': 'settings',
      'favorite': 'favorite',
      'share': 'share',
      'add': 'add',
      'delete': 'delete',
      'edit': 'edit',
      'info': 'info',
      'warning': 'warning',
      'error': 'error',
      'check': 'check',
      'moreVert': 'more_vert',
      'moreHoriz': 'more_horiz',
    };

    final iconsRaw = json['icons'];
    final config = iconsRaw != null
        ? {...defaults, ...Map<String, dynamic>.from(iconsRaw as Map)}
        : defaults;

    return AppIcons._(config);
  }

  IconData get back => _getIcon('back', Icons.arrow_back);
  IconData get close => _getIcon('close', Icons.close);
  IconData get menu => _getIcon('menu', Icons.menu);
  IconData get search => _getIcon('search', Icons.search);
  IconData get home => _getIcon('home', Icons.home);
  IconData get settings => _getIcon('settings', Icons.settings);
  IconData get favorite => _getIcon('favorite', Icons.favorite);
  IconData get share => _getIcon('share', Icons.share);
  IconData get add => _getIcon('add', Icons.add);
  IconData get delete => _getIcon('delete', Icons.delete);
  IconData get edit => _getIcon('edit', Icons.edit);
  IconData get info => _getIcon('info', Icons.info);
  IconData get warning => _getIcon('warning', Icons.warning);
  IconData get error => _getIcon('error', Icons.error);
  IconData get check => _getIcon('check', Icons.check);
  IconData get moreVert => _getIcon('moreVert', Icons.more_vert);
  IconData get moreHoriz => _getIcon('moreHoriz', Icons.more_horiz);

  IconData _getIcon(String key, IconData fallback) {
    final name = _iconConfigs[key];
    if (name is String) {
      return iconMap[name] ?? fallback;
    }
    return fallback;
  }

  static final Map<String, IconData> iconMap = {
    'arrow_back': Icons.arrow_back,
    'close': Icons.close,
    'menu': Icons.menu,
    'search': Icons.search,
    'home': Icons.home,
    'settings': Icons.settings,
    'favorite': Icons.favorite,
    'share': Icons.share,
    'add': Icons.add,
    'delete': Icons.delete,
    'edit': Icons.edit,
    'info': Icons.info,
    'warning': Icons.warning,
    'error': Icons.error,
    'check': Icons.check,
    'more_vert': Icons.more_vert,
    'more_horiz': Icons.more_horiz,
  };
}
