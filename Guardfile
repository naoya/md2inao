# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :tap, command: 'carton exec -Ilib -- perl' do
  watch %r{^t/.*\.t$}
  watch %r{^(lib/.*\.pm)$} do |m|
    modified_file = m[0]

    all_test_files = Dir.glob('t/**/**.t')

    all_test_files.sort_by{ |test_file|
      # sort by similarity of path
      a = test_file
      b = modified_file
      delimiter = %r{[/_\-\.]}
      a_fragments = a.split(delimiter)
      b_fragments = b.split(delimiter)
      (a_fragments + b_fragments).uniq.length.to_f / (a_fragments + b_fragments).length.to_f
    }.first
  end
end
