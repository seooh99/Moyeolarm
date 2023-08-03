
import 'dart:io';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

final emulatorIp = 'http://i9a502.p.ssafy.io:8080';
final simulatorIp = 'http://i9a502.p.ssafy.io:8080';

final ip = Platform.isIOS ? simulatorIp : emulatorIp;