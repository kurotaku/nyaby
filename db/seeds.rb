# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ユーザー登録
root_user = User.new(name: 'root user', email: 'root@root.com', root: true, admin: true)
root_user.password = 'root'
root_user.password_confirmation = 'root'
root_user.save!

admin_user = User.new(name: '管理者', email: 'admin@admin.com', root: false, admin: true)
admin_user.password = 'admin'
admin_user.password_confirmation = 'admin'
admin_user.save!

test_user = User.new(name: 'テストユーザー', email: 'test@test.com', root: false, admin: false)
test_user.password = 'test'
test_user.password_confirmation = 'test'
test_user.save!


# カテゴリー登録
Category.create(name: '食事', slug: 'meal', category_type: 'gourmet')
Category.create(name: 'ディナー', slug: 'dinner', category_type: 'gourmet')
Category.create(name: 'ランチ', slug: 'lunch', category_type: 'gourmet')
Category.create(name: 'カフェ', slug: 'cafe', category_type: 'gourmet')
Category.create(name: '居酒屋・バー', slug: 'bar', category_type: 'gourmet')
Category.create(name: 'スイーツ', slug: 'sweets', category_type: 'gourmet')

Category.create(name: '美術館', slug: 'art_museum ', category_type: 'art')
Category.create(name: '博物館', slug: 'museum ', category_type: 'art')
Category.create(name: '科学館', slug: 'science_museum ', category_type: 'art')
Category.create(name: '映画館', slug: 'theatre ', category_type: 'art')

Category.create(name: '絶景スポット', slug: 'view_spot ', category_type: 'view_spot')
Category.create(name: '撮影スポット', slug: 'photo_spot ', category_type: 'view_spot')

Category.create(name: '服屋', slug: 'cloth ', category_type: 'shopping')
Category.create(name: '雑貨', slug: 'goods ', category_type: 'shopping')

Category.create(name: 'アミューズメント', slug: 'amusement ', category_type: 'other')
