import 'package:core/theme/collection_symbol.dart';
import 'package:flutter/material.dart';

extension CollectionSymbolExtensions on CollectionSymbol {
  IconData toIcon() {
    return switch (this) {
      CollectionSymbol.spark => Icons.auto_awesome_rounded,
      CollectionSymbol.leaf => Icons.eco_rounded,
      CollectionSymbol.grass => Icons.grass_rounded,
      CollectionSymbol.wave => Icons.waves_rounded,
      CollectionSymbol.mountain => Icons.landscape_rounded,
      CollectionSymbol.moon => Icons.nightlight_round,
      CollectionSymbol.sun => Icons.wb_sunny_rounded,
      CollectionSymbol.flame => Icons.local_fire_department_rounded,
      CollectionSymbol.bolt => Icons.bolt_rounded,
      CollectionSymbol.key => Icons.vpn_key_rounded,
      CollectionSymbol.anchor => Icons.anchor_rounded,
      CollectionSymbol.compass => Icons.explore_rounded,
      CollectionSymbol.globe => Icons.public_rounded,
      CollectionSymbol.map => Icons.map_rounded,
      CollectionSymbol.eye => Icons.visibility_rounded,
      CollectionSymbol.clock => Icons.schedule_rounded,
      CollectionSymbol.crown => Icons.workspace_premium_rounded,
      CollectionSymbol.puzzle => Icons.extension_rounded,
      CollectionSymbol.music => Icons.music_note_rounded,
      CollectionSymbol.flask => Icons.science_rounded,
    };
  }
}
