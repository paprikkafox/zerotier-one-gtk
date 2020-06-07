namespace AppComponents {

	[GtkTemplate (ui = "/org/github/paprikkafox/zerotier-one-gtk/ui/components/network-row.ui")]
	public class NetworkRow : Gtk.ListBoxRow {

        [GtkChild] Gtk.Label network_name_label;
        [GtkChild] Gtk.Label network_id_label;

        [GtkChild] Gtk.Label assigned_ips_label;
        [GtkChild] Gtk.Label auth_status_label;
        [GtkChild] Gtk.Label network_type_label;

	    public NetworkRow (
	        string network_name,
	        string network_id,
            string auth_status,
            string network_type,
            string assigned_ips)
            {

                network_name_label.set_text(network_name);
                network_id_label.set_text(network_id);

                auth_status_label.set_text(auth_status);
                network_type_label.set_text(network_type);
                assigned_ips_label.set_text(assigned_ips);

            }
	}
}
