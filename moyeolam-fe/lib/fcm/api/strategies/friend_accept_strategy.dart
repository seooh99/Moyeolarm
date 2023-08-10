import 'package:dio/dio.dart';

class FriendAcceptStrategy {
  final Dio _dio = Dio(); // 미리 생성된 Dio 인스턴스 사용

  void execute(String memberId, String friendRequestId, bool isAccepted) async {
    try {
      // 초기 GET 요청 수행
      // memberId 값을 이용하여 친구 수락에 따른 API 요청 처리
      Response response = await _dio.get('/friends/$memberId/request');

      if (response.statusCode == 200) {
        // API 요청 성공 처리
        print('친구 수락 API 요청 성공');
        print('Response Data: ${response.data}');

        if (isAccepted) {
          await ApproveFriend(friendRequestId);
        } else {
          await ApproveFriend(friendRequestId);
        }

      } else {
        // API 요청 실패 처리
        print('친구 수락 API 요청 실패');
      }
    } catch (e) {
      // 예외 처리
      print('친구 수락 API 요청 예외: $e');
    }
  }

  Future<void> ApproveFriend(String friendRequestId) async {
    try {
      // 알람 그룹 수락을 위한 API 요청 수행
      Response response = await _dio.post('/friends/$friendRequestId/approve');

      if (response.statusCode == 200) {
        print('수락 API 요청 성공');
        print('응답 데이터: ${response.data}');
      } else {
        print('수락 API 요청 실패');
      }
    } on DioError catch (e) {
      print('DioError 발생!!: $e');
    } catch (e) {
      print('수락 API 요청 예외 발생~~~?: $e');
    }
  }

  Future<void> DeclineFriend(String friendRequestId) async {
    try {
      // 알람 그룹 거절을 위한 API 요청 수행
      Response response = await _dio.post('/friends/$friendRequestId/reject');

      if (response.statusCode == 200) {
        print('거절 API 요청 성공');
        print('응답 데이터: ${response.data}');
      } else {
        print('거절 API 요청 실패');
      }
    } on DioError catch (e) {
      print('DioError 발생!!: $e');
    } catch (e) {
      print('거절 API 요청 예외 발생: $e');
    }
  }
}

