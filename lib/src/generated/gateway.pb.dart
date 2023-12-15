//
//  Generated code. Do not modify.
//  source: proto/gateway/v1/gateway.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// A request for a prompt - sending user input to the server.
class PromptRequest extends $pb.GeneratedMessage {
  factory PromptRequest({
    $core.Map<$core.String, $core.String>? templateVariables,
    $core.String? promptConfigId,
  }) {
    final $result = create();
    if (templateVariables != null) {
      $result.templateVariables.addAll(templateVariables);
    }
    if (promptConfigId != null) {
      $result.promptConfigId = promptConfigId;
    }
    return $result;
  }
  PromptRequest._() : super();
  factory PromptRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PromptRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PromptRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'gateway.v1'), createEmptyInstance: create)
    ..m<$core.String, $core.String>(1, _omitFieldNames ? '' : 'templateVariables', entryClassName: 'PromptRequest.TemplateVariablesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('gateway.v1'))
    ..aOS(2, _omitFieldNames ? '' : 'promptConfigId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PromptRequest clone() => PromptRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PromptRequest copyWith(void Function(PromptRequest) updates) => super.copyWith((message) => updates(message as PromptRequest)) as PromptRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PromptRequest create() => PromptRequest._();
  PromptRequest createEmptyInstance() => create();
  static $pb.PbList<PromptRequest> createRepeated() => $pb.PbList<PromptRequest>();
  @$core.pragma('dart2js:noInline')
  static PromptRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PromptRequest>(create);
  static PromptRequest? _defaultInstance;

  /// The User prompt variables
  /// This is a hash-map of variables that should have the same keys as those contained by the PromptConfigResponse
  @$pb.TagNumber(1)
  $core.Map<$core.String, $core.String> get templateVariables => $_getMap(0);

  /// Optional Identifier designating the prompt config ID to use. If not set, the default prompt config will be used.
  @$pb.TagNumber(2)
  $core.String get promptConfigId => $_getSZ(1);
  @$pb.TagNumber(2)
  set promptConfigId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPromptConfigId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPromptConfigId() => clearField(2);
}

/// A Prompt Response Message
class PromptResponse extends $pb.GeneratedMessage {
  factory PromptResponse({
    $core.String? content,
    $core.int? requestTokens,
    $core.int? responseTokens,
    $core.int? requestDuration,
  }) {
    final $result = create();
    if (content != null) {
      $result.content = content;
    }
    if (requestTokens != null) {
      $result.requestTokens = requestTokens;
    }
    if (responseTokens != null) {
      $result.responseTokens = responseTokens;
    }
    if (requestDuration != null) {
      $result.requestDuration = requestDuration;
    }
    return $result;
  }
  PromptResponse._() : super();
  factory PromptResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PromptResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PromptResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'gateway.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'content')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'requestTokens', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'responseTokens', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'requestDuration', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PromptResponse clone() => PromptResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PromptResponse copyWith(void Function(PromptResponse) updates) => super.copyWith((message) => updates(message as PromptResponse)) as PromptResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PromptResponse create() => PromptResponse._();
  PromptResponse createEmptyInstance() => create();
  static $pb.PbList<PromptResponse> createRepeated() => $pb.PbList<PromptResponse>();
  @$core.pragma('dart2js:noInline')
  static PromptResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PromptResponse>(create);
  static PromptResponse? _defaultInstance;

  /// Prompt Content
  @$pb.TagNumber(1)
  $core.String get content => $_getSZ(0);
  @$pb.TagNumber(1)
  set content($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContent() => $_has(0);
  @$pb.TagNumber(1)
  void clearContent() => clearField(1);

  /// Number of tokens used for the prompt request
  @$pb.TagNumber(2)
  $core.int get requestTokens => $_getIZ(1);
  @$pb.TagNumber(2)
  set requestTokens($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRequestTokens() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequestTokens() => clearField(2);

  /// Number of tokens used for the prompt response
  @$pb.TagNumber(3)
  $core.int get responseTokens => $_getIZ(2);
  @$pb.TagNumber(3)
  set responseTokens($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasResponseTokens() => $_has(2);
  @$pb.TagNumber(3)
  void clearResponseTokens() => clearField(3);

  /// Request duration
  @$pb.TagNumber(4)
  $core.int get requestDuration => $_getIZ(3);
  @$pb.TagNumber(4)
  set requestDuration($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRequestDuration() => $_has(3);
  @$pb.TagNumber(4)
  void clearRequestDuration() => clearField(4);
}

/// An Streaming Prompt Response Message
class StreamingPromptResponse extends $pb.GeneratedMessage {
  factory StreamingPromptResponse({
    $core.String? content,
    $core.String? finishReason,
    $core.int? requestTokens,
    $core.int? responseTokens,
    $core.int? streamDuration,
  }) {
    final $result = create();
    if (content != null) {
      $result.content = content;
    }
    if (finishReason != null) {
      $result.finishReason = finishReason;
    }
    if (requestTokens != null) {
      $result.requestTokens = requestTokens;
    }
    if (responseTokens != null) {
      $result.responseTokens = responseTokens;
    }
    if (streamDuration != null) {
      $result.streamDuration = streamDuration;
    }
    return $result;
  }
  StreamingPromptResponse._() : super();
  factory StreamingPromptResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StreamingPromptResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StreamingPromptResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'gateway.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'content')
    ..aOS(2, _omitFieldNames ? '' : 'finishReason')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'requestTokens', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'responseTokens', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'streamDuration', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StreamingPromptResponse clone() => StreamingPromptResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StreamingPromptResponse copyWith(void Function(StreamingPromptResponse) updates) => super.copyWith((message) => updates(message as StreamingPromptResponse)) as StreamingPromptResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamingPromptResponse create() => StreamingPromptResponse._();
  StreamingPromptResponse createEmptyInstance() => create();
  static $pb.PbList<StreamingPromptResponse> createRepeated() => $pb.PbList<StreamingPromptResponse>();
  @$core.pragma('dart2js:noInline')
  static StreamingPromptResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StreamingPromptResponse>(create);
  static StreamingPromptResponse? _defaultInstance;

  /// Prompt Content
  @$pb.TagNumber(1)
  $core.String get content => $_getSZ(0);
  @$pb.TagNumber(1)
  set content($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContent() => $_has(0);
  @$pb.TagNumber(1)
  void clearContent() => clearField(1);

  /// Finish reason, given when the stream ends
  @$pb.TagNumber(2)
  $core.String get finishReason => $_getSZ(1);
  @$pb.TagNumber(2)
  set finishReason($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFinishReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearFinishReason() => clearField(2);

  /// Number of tokens used for the prompt request, given when the stream ends
  @$pb.TagNumber(3)
  $core.int get requestTokens => $_getIZ(2);
  @$pb.TagNumber(3)
  set requestTokens($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRequestTokens() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequestTokens() => clearField(3);

  /// Number of tokens used for the prompt response, given when the stream ends
  @$pb.TagNumber(4)
  $core.int get responseTokens => $_getIZ(3);
  @$pb.TagNumber(4)
  set responseTokens($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasResponseTokens() => $_has(3);
  @$pb.TagNumber(4)
  void clearResponseTokens() => clearField(4);

  /// Stream duration, given when the stream ends
  @$pb.TagNumber(5)
  $core.int get streamDuration => $_getIZ(4);
  @$pb.TagNumber(5)
  set streamDuration($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasStreamDuration() => $_has(4);
  @$pb.TagNumber(5)
  void clearStreamDuration() => clearField(5);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
