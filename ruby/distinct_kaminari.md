[Kaminari](https://github.com/amatsuda/kaminari) 是Rails中非常好用的分页gem。只用讲起添加到Rails项目中，就能很轻松的实现分页功能。

```
User.page(7).per(50)
```

关于Kaminari的使用github文档已经描述的很清楚，本文将讨论在Kaminari中如何对重复数据进行处理。

##如何在数据库层unique数据

###ActiveRecord里有什么

ActiveRecord中提供了`uniq`和`distinct`方法，用来去除查询结果中的重复数据。但是这两个方法只适用于获取单列数据的场景:
```
select name from users;
```
如果碰到多数据场景，将无能为力:
```
select * from users;
```

###使用PostgresSQL中的特性解决问题

Postgres中提供了distinct方法，可以用来支持unique多列数据的场景
```
select distinct on(name) * from users order by created_at desc;
```

我们可以在Activerecord中使用postgres中的特性实现unique

```
uniqued_users = User.select('distinct on (name) *').order(created_at: desc)
```

###新问题产生:ActiveRecord方法罢工

虽然采用PostgresSQL特性解决了unique问题，但是新的问题产生. 如果直接调用ActiveRecord `count`方法，你将会的到SQL异常.此时必须将distinct内容传给count方法.

```
uniqued_users = User.select('distinct on(name) *').order(created_at: desc)
uniqued_users.count('distinct name')
```

##Distinct对Kaminari的影响

```
class Api::DistinctPaginator
  def initialize(association, distinct_column:, size:)
    @association = association
    @distinct_column = distinct_column
    @size = size
  end

  def page(page)
    paginated_records = @association.page(page).per(@size)
    reassign_total_count(paginated_records.to_a,
             total_count: paginated_records.total_count("distinct #{@distinct_column}"),
             page: page,
             size: @size)
  end

  private

  def reassign_total_count(data_array, page:, size:, total_count:)
    Kaminari.paginate_array(data_array, total_count: total_count)
      .page(page).per(size).offset((page - 1) * size)
  end
end
```
