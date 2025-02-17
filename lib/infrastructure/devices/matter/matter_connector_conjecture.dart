import 'dart:async';
import 'dart:collection';

import 'package:cbj_hub/infrastructure/devices/matter/matter_helpers.dart';
import 'package:cbj_integrations_controller/integrations_controller.dart';

class MatterConnectorConjecture extends VendorConnectorConjectureService {
  factory MatterConnectorConjecture() {
    return _instance;
  }

  MatterConnectorConjecture._singletonContractor()
      : super(
          VendorsAndServices.matter,
          displayName: 'Matter',
          imageUrl:
              'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.5oTC_gXhq0Tm5U-jFh8MQAHaFj%26pid%3DApi&f=1&ipt=3784aeff30dcaabb602b299e96c2a280e4bfdd0d309fcc3d54d006c04743cdb9&ipo=images',
          uniqeMdnsList: ['_matter._tcp.local', '_matterc._udp.local'],
          uniqueIdentifierNameInMdns: ['matter'],
        );

  static final MatterConnectorConjecture _instance =
      MatterConnectorConjecture._singletonContractor();

  @override
  Future<HashMap<String, DeviceEntityBase>> newEntityToVendorDevice(
    DeviceEntityBase entity, {
    bool fromDb = false,
  }) =>
      MatterHelpers.addDiscoveredDevice(entity);
}
