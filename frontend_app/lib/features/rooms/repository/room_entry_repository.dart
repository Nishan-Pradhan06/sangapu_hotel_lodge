import 'package:dartz/dartz.dart';

import '../../../common/typedef/either_type.dart';
import '../../../core/network/api_services.dart';
import '../models/room_entry_model.dart';

abstract interface class RoomEntryRepository {
  FutureEither<RoomEntryModel> roomEntries({required RoomEntryModel roomEntry});
}

class RoomEntryRepositoryImpl implements RoomEntryRepository {
  final ApiService _apiService;

  RoomEntryRepositoryImpl({required ApiService apiService})
    : _apiService = apiService;

  @override
  FutureEither<RoomEntryModel> roomEntries({
    required RoomEntryModel roomEntry,
  }) async {
    final response = await _apiService.post<Map<String, dynamic>>(
      'rooms/entries/',
      data: roomEntry.toMap(),
    );

    return response.fold((failure) => Left(failure), (success) async {
      return Right(RoomEntryModel.fromMap(success));
    });
  }
}
