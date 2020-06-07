namespace AppComponents {

	[GtkTemplate (ui = "/org/github/paprikkafox/zerotier-one-gtk/ui/window.ui")]
	public class Window : Gtk.ApplicationWindow {
		public Window (Gtk.Application app) {
			Object (application: app);

		}


	}

}
