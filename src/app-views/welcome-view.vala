namespace AppComponents {

	[GtkTemplate (ui = "/org/github/paprikkafox/zerotier-one-gtk/ui/views/welcome-view.ui")]
	public class WelcomeView : Gtk.Box {

	[GtkChild] Gtk.Entry network_id_entry;
    [GtkChild] Gtk.Button welcome_connect_button;

		public WelcomeView () {
            welcome_connect_button.clicked.connect(() => {
                new AppComponents.CliTools().connectToNetwork(network_id_entry.get_text());
            });

		}

	}

}
