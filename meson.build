project('com.github.paprikkafox.zerotier-one-gtk', ['vala', 'c'],
    version : '0.1.0',
    license: 'GPL-3.0'
)

gnome = import('gnome')
i18n = import('i18n')

gresource = gnome.compile_resources(
    'as-resources', 'data/com.github.paprikkafox.zerotier-one-gtk.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

conf = configuration_data()
conf.set_quoted('GETTEXT_PACKAGE', meson.project_name())
configure_file(output: 'config.h', configuration: conf)
config_h_dir = include_directories('.')

c_args = [
  '-include', 'config.h',
  '-DGWEATHER_I_KNOW_THIS_IS_UNSTABLE',
]

subdir('data')
subdir('po')
subdir('src')

executable('com.github.paprikkafox.zerotier-one-gtk',
    sources,
    gresource,
    c_args: c_args,
    dependencies :[
        dependency('granite'),
        dependency('gobject-2.0'),
        dependency('gtk+-3.0'),
        dependency('glib-2.0'),
        dependency('json-glib-1.0', version: '1.4.4'),
    ],
    install : true
)

meson.add_install_script('post_install.py')