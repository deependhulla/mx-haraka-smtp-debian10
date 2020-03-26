//'use strict';
// Call spamassassin via spamd

var utils = require('haraka-utils');

//plugin.logdebug("he just really likes turtles", connection);

exports.register = function () {
    var plugin = this;
//plugin.register_hook('rcpt', 'rcpt_addnow');

};




exports.hook_rcpt = function (next, connection, params) {
	var rcpt = params[0];
	this.loginfo("Got recipient1: " + rcpt);
//var txn = connection.transaction;
connection.transaction.add_header('KKKKK','YYYYYY');
//txn.add_header('MXDeliveredTo', rcpt);
	this.loginfo("Got recipient2: " + rcpt);
	next();
}
