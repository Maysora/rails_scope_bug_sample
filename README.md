Example minimum project for strange behavior when self-referential association parent scope carried over to children.

### TEST

sample run:

```
$ rake test
Run options: --seed 7585

# Running:

children sql: SELECT "categories".* FROM "categories" WHERE "categories"."parent_id" IS NULL AND "categories"."parent_id" = 980190963
children sql: SELECT "categories".* FROM "categories" WHERE "categories"."parent_id" = 980190963 AND "categories"."parent_id" = 980190964
children sql: SELECT "categories".* FROM "categories" WHERE "categories"."parent_id" = 980190963 AND "categories"."parent_id" = 980190965
children sql: SELECT "categories".* FROM "categories" WHERE "categories"."parent_id" = 980190963 AND "categories"."parent_id" = 980190966
children sql: SELECT "categories".* FROM "categories" WHERE "categories"."parent_id" IS NULL AND "categories"."parent_id" = 980190967
children sql: SELECT "categories".* FROM "categories" WHERE "categories"."parent_id" = 980190967 AND "categories"."parent_id" = 980190968
children sql: SELECT "categories".* FROM "categories" WHERE "categories"."parent_id" = 980190967 AND "categories"."parent_id" = 980190969
children sql: SELECT "categories".* FROM "categories" WHERE "categories"."parent_id" IS NULL AND "categories"."parent_id" = 980190963
children sql: SELECT "categories".* FROM "categories" WHERE "categories"."parent_id" IS NULL AND "categories"."parent_id" = 980190967
F

Finished in 0.144866s, 6.9029 runs/s, 6.9029 assertions/s.

  1) Failure:
CategoryTest#test_.map_nested_names [/home/maysora/scope_test/test/models/category_test.rb:12]:
--- expected
+++ actual
@@ -1 +1 @@
-["a", "-a1", "-a2", "-a3", "b", "-b1", "-b2"]
+["a", "b"]
```

as can be seen, children sql query carry over `roots` scope (parent_id: nil) which results none of the children returned.
