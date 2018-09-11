$(function() {

			/* Sidebar tree view */
			$(".sidebar .treeview").tree();

			jQuery.fn.zrPageRefresh = function(options) {
				if (typeof options === 'string') {
					options = {
						url : options
					};
				}
				// Render options
				var settings = $.extend({
					url : "",
					onLoadStart : function(dom) {
					},
					onLoadDone : function(dom) {
					}
				}, options);

				
				//The overlay
				var overlay = $('<div class="overlay"></div><div class="loading-img"></div>');

				return this
						.each(function() {
							//if a source is specified
							if (settings.url === "") {
								if (console) {
									console
											.log("Please specify a URL first - zrPageRefresh()");
								}
								return;
							}
							//the dom
							var dom = $(this);
							$("body").append(overlay);
							dom.load(settings.url, function() {
								$("body").find(overlay).remove();
							});
						});
			};

			$("#main-content").zrPageRefresh(webpath+"/statics/index");
			$(".sidebar-menu a").click(function() {
				var href = $(this).attr("href");
				if (href != "" && href != "#") {
					//location.href=location.href+"#"+href;
					$("#main-content").zrPageRefresh(webpath+href);
				}
				return false;
			});
			
		});