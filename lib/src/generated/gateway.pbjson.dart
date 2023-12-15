//
//  Generated code. Do not modify.
//  source: proto/gateway/v1/gateway.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use promptRequestDescriptor instead')
const PromptRequest$json = {
  '1': 'PromptRequest',
  '2': [
    {'1': 'template_variables', '3': 1, '4': 3, '5': 11, '6': '.gateway.v1.PromptRequest.TemplateVariablesEntry', '10': 'templateVariables'},
    {'1': 'prompt_config_id', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'promptConfigId', '17': true},
  ],
  '3': [PromptRequest_TemplateVariablesEntry$json],
  '8': [
    {'1': '_prompt_config_id'},
  ],
};

@$core.Deprecated('Use promptRequestDescriptor instead')
const PromptRequest_TemplateVariablesEntry$json = {
  '1': 'TemplateVariablesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `PromptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List promptRequestDescriptor = $convert.base64Decode(
    'Cg1Qcm9tcHRSZXF1ZXN0El8KEnRlbXBsYXRlX3ZhcmlhYmxlcxgBIAMoCzIwLmdhdGV3YXkudj'
    'EuUHJvbXB0UmVxdWVzdC5UZW1wbGF0ZVZhcmlhYmxlc0VudHJ5UhF0ZW1wbGF0ZVZhcmlhYmxl'
    'cxItChBwcm9tcHRfY29uZmlnX2lkGAIgASgJSABSDnByb21wdENvbmZpZ0lkiAEBGkQKFlRlbX'
    'BsYXRlVmFyaWFibGVzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZh'
    'bHVlOgI4AUITChFfcHJvbXB0X2NvbmZpZ19pZA==');

@$core.Deprecated('Use promptResponseDescriptor instead')
const PromptResponse$json = {
  '1': 'PromptResponse',
  '2': [
    {'1': 'content', '3': 1, '4': 1, '5': 9, '10': 'content'},
    {'1': 'request_tokens', '3': 2, '4': 1, '5': 13, '10': 'requestTokens'},
    {'1': 'response_tokens', '3': 3, '4': 1, '5': 13, '10': 'responseTokens'},
    {'1': 'request_duration', '3': 4, '4': 1, '5': 13, '10': 'requestDuration'},
  ],
};

/// Descriptor for `PromptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List promptResponseDescriptor = $convert.base64Decode(
    'Cg5Qcm9tcHRSZXNwb25zZRIYCgdjb250ZW50GAEgASgJUgdjb250ZW50EiUKDnJlcXVlc3RfdG'
    '9rZW5zGAIgASgNUg1yZXF1ZXN0VG9rZW5zEicKD3Jlc3BvbnNlX3Rva2VucxgDIAEoDVIOcmVz'
    'cG9uc2VUb2tlbnMSKQoQcmVxdWVzdF9kdXJhdGlvbhgEIAEoDVIPcmVxdWVzdER1cmF0aW9u');

@$core.Deprecated('Use streamingPromptResponseDescriptor instead')
const StreamingPromptResponse$json = {
  '1': 'StreamingPromptResponse',
  '2': [
    {'1': 'content', '3': 1, '4': 1, '5': 9, '10': 'content'},
    {'1': 'finish_reason', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'finishReason', '17': true},
    {'1': 'request_tokens', '3': 3, '4': 1, '5': 13, '9': 1, '10': 'requestTokens', '17': true},
    {'1': 'response_tokens', '3': 4, '4': 1, '5': 13, '9': 2, '10': 'responseTokens', '17': true},
    {'1': 'stream_duration', '3': 5, '4': 1, '5': 13, '9': 3, '10': 'streamDuration', '17': true},
  ],
  '8': [
    {'1': '_finish_reason'},
    {'1': '_request_tokens'},
    {'1': '_response_tokens'},
    {'1': '_stream_duration'},
  ],
};

/// Descriptor for `StreamingPromptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamingPromptResponseDescriptor = $convert.base64Decode(
    'ChdTdHJlYW1pbmdQcm9tcHRSZXNwb25zZRIYCgdjb250ZW50GAEgASgJUgdjb250ZW50EigKDW'
    'ZpbmlzaF9yZWFzb24YAiABKAlIAFIMZmluaXNoUmVhc29uiAEBEioKDnJlcXVlc3RfdG9rZW5z'
    'GAMgASgNSAFSDXJlcXVlc3RUb2tlbnOIAQESLAoPcmVzcG9uc2VfdG9rZW5zGAQgASgNSAJSDn'
    'Jlc3BvbnNlVG9rZW5ziAEBEiwKD3N0cmVhbV9kdXJhdGlvbhgFIAEoDUgDUg5zdHJlYW1EdXJh'
    'dGlvbogBAUIQCg5fZmluaXNoX3JlYXNvbkIRCg9fcmVxdWVzdF90b2tlbnNCEgoQX3Jlc3Bvbn'
    'NlX3Rva2Vuc0ISChBfc3RyZWFtX2R1cmF0aW9u');
