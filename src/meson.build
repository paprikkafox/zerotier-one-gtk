zerotieronegtk_sources = [
  'app.vala',
]

subdir('app-views')

zerotieronegtk_deps = [
  dependency('gio-2.0', version: '>= 2.50'),
  dependency('gtk+-3.0', version: '>= 3.22'),
]

gnome = import('gnome')

zerotieronegtk_sources += gnome.compile_resources('zerotieronegtk-resources',
  'zerotieronegtk.gresource.xml',
  c_name: 'zerotieronegtk'
)

executable('zerotieronegtk', zerotieronegtk_sources,
  vala_args: '--target-glib=2.50',  dependencies: zerotieronegtk_deps,
  install: true,
)


