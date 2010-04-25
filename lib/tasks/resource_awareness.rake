task :resources => :environment do
  width_of_widest_route_id = Rails.application.resources.collect(&:id).max.length
  puts Rails.application.resources.collect { |r| "%-#{width_of_widest_route_id + 20}s%s" % [r.id, r.path] }
end                                                          