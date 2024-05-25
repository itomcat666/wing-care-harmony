import { preferences } from '@kit.ArkData'

class UserStore {
  KEY = 'user-store'

  // 方法
  getStore() {
    return preferences.getPreferencesSync(getContext(), { name: 'UserStore' })
  }

  // 设置用户
  async setUser(data: User) {
    const store = this.getStore()
    store.putSync(this.KEY, JSON.stringify(data))
    await store.flush()
  }

  // 获取用户
  getUser() {
    const store = this.getStore()
    const data = store.getSync(this.KEY, '{}') as string
    return JSON.parse(data) as string
  }

  // 删除用户
  async delUser() {
    const store = this.getStore()
    store.deleteSync(this.KEY)
    await store.flush()
  }
}

export class User {
  token: string = ''
}

export const userStore = new UserStore()