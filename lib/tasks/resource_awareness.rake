task :resources => :environment do
  widest_route_id = Rails.application.resources.collect(&:id).max
  puts Rails.application.resources.collect { |r| "%-#{widest_route_id.length + 20}s%s" % [r.id, r.route.path.sub('(.:format)', '')] }
end                                                          