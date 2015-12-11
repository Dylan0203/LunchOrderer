atom_feed do |feed|
  feed.title( @feed_title )
  feed.updated( @people.last.created_at )
  @people.each do |person|
    feed.entry(person) do |entry|
      entry.title( person.name )
      entry.content( person.item, :type => 'html' )
      entry.content( person.quantity)
      entry.content( person.price)
      entry.content( person.remark, :type => 'html')
    end
  end
end