library googleapis.admin.email_migration_v2.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;
import 'package:googleapis/common/common.dart' as common;
import 'package:googleapis/src/common_internal.dart' as common_internal;
import '../common/common_internal_test.dart' as common_test;

import 'package:googleapis/admin/email_migration_v2.dart' as api;



buildUnnamed763() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed763(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterMailItem = 0;
buildMailItem() {
  var o = new api.MailItem();
  buildCounterMailItem++;
  if (buildCounterMailItem < 3) {
    o.isDeleted = true;
    o.isDraft = true;
    o.isInbox = true;
    o.isSent = true;
    o.isStarred = true;
    o.isTrash = true;
    o.isUnread = true;
    o.kind = "foo";
    o.labels = buildUnnamed763();
  }
  buildCounterMailItem--;
  return o;
}

checkMailItem(api.MailItem o) {
  buildCounterMailItem++;
  if (buildCounterMailItem < 3) {
    unittest.expect(o.isDeleted, unittest.isTrue);
    unittest.expect(o.isDraft, unittest.isTrue);
    unittest.expect(o.isInbox, unittest.isTrue);
    unittest.expect(o.isSent, unittest.isTrue);
    unittest.expect(o.isStarred, unittest.isTrue);
    unittest.expect(o.isTrash, unittest.isTrue);
    unittest.expect(o.isUnread, unittest.isTrue);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed763(o.labels);
  }
  buildCounterMailItem--;
}


main() {
  unittest.group("obj-schema-MailItem", () {
    unittest.test("to-json--from-json", () {
      var o = buildMailItem();
      var od = new api.MailItem.fromJson(o.toJson());
      checkMailItem(od);
    });
  });


  unittest.group("resource-MailResourceApi", () {
    unittest.test("method--insert", () {
      // TODO: Implement tests for media upload;
      // TODO: Implement tests for media download;

      var mock = new common_test.HttpServerMock();
      api.MailResourceApi res = new api.AdminApi(mock).mail;
      var arg_request = buildMailItem();
      var arg_userKey = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.MailItem.fromJson(json);
        checkMailItem(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(common_test.stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request, arg_userKey).then(unittest.expectAsync((_) {}));
    });

  });


}
