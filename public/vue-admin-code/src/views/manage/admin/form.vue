<template>
  <el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible">
    <el-form ref="dataForm" :rules="rules" :model="temp" label-position="left" label-width="70px" style="width: 100%; height: 50vh;overflow-y: scroll;">
      <el-form-item label="角色" prop="groupId">
        <el-select v-model="temp.groupId" class="filter-item" placeholder="请选择">
          <el-option v-for="item in roles" :key="item.id" :label="item.title" :value="item.id" />
        </el-select>
      </el-form-item>
      <el-form-item label="账号" prop="userName">
        <el-input v-model="temp.userName" clearable/>
      </el-form-item>
      <el-form-item label="密码" prop="password">
        <el-input v-model="temp.password" clearable/>
      </el-form-item>
      <el-form-item label="头像" prop="img">
        <Upload v-model="temp.img" :config="config"/>
      </el-form-item>
      <el-form-item label="姓名" prop="realName">
        <el-input v-model="temp.realName" clearable/>
      </el-form-item>
      <el-form-item label="手机" prop="phone">
        <el-input v-model="temp.phone" clearable/>
      </el-form-item>
      <el-form-item label="邮箱" prop="email">
        <el-input v-model="temp.email" clearable/>
      </el-form-item>
      <el-form-item label="状态">
        <el-radio-group v-model="temp.isEnabled">
          <el-radio :label="1">正常</el-radio>
          <el-radio :label="0">禁用</el-radio>
        </el-radio-group>
      </el-form-item>
    </el-form>
    <div slot="footer" class="dialog-footer">
      <el-button @click="dialogFormVisible = false">取消</el-button>
      <el-button :loading="btnLoading" type="primary" @click="saveData()">保存</el-button>
    </div>
  </el-dialog>
</template>

<script>
import Upload from '@/components/Upload/image'
import { getListAll } from '@/api/roles'
import { getinfo, save } from '@/api/admin'
import { formatImgToArr } from '@/utils'

export default {
  name: 'AdminForm',
  components: { Upload },
  data() {
    return {
      btnLoading: false,
      roles: {},
      temp: {
        id: 0,
        groupId: '',
        userName: '',
        password: '',
        realName: '',
        isEnabled: 1,
        phone: '',
        email: '',
        img: []
      },
      config: {
        fileName: 'img',
        limit: 1,
        multiple: true,
        accept: 'image/*',
        action: 'http://en.hardphp.com/index.php/admin/upload/upimage'
      },
      dialogFormVisible: false,
      dialogStatus: '',
      textMap: {
        update: '编辑',
        create: '添加'
      },
      rules: {
        groupId: [{ required: true, message: '角色必选', trigger: 'change' }],
        userName: [{ required: true, message: '账号必填', trigger: 'blur' }]
      }

    }
  },
  watch: {
    dialogFormVisible: function() {
      this.resetTemp()
    },
    temp: {
      handler(newVal, oldVal) {},
      immediate: true,
      deep: true
    }
  },
  created() {
    this.getRoles()
  },
  destroyed() {

  },
  methods: {
    getRoles() {
      getListAll().then(response => {
        this.roles = response.data
      })
    },
    resetTemp() {
      this.temp = {
        id: 0,
        groupId: '',
        userName: '',
        password: '',
        realName: '',
        isEnabled: 1,
        phone: '',
        email: '',
        img: []
      }
    },
    handleCreate() {
      this.dialogStatus = 'create'
      this.dialogFormVisible = true
      this.currentIndex = -1
      this.$nextTick(() => {
        this.$refs['dataForm'].clearValidate()
      })
    },
    handleUpdate(id) {
      this.dialogStatus = 'update'
      this.dialogFormVisible = true
      const _this = this
      getinfo(id).then(response => {
        if (response.status === 1) {
          _this.temp = Object.assign({}, response.data)
          _this.temp.password = ''
          _this.temp.img = formatImgToArr(_this.temp.img)
        }
      })
      this.$nextTick(() => {
        this.$refs['dataForm'].clearValidate()
      })
    },
    saveData() {
      this.btnLoading = true
      this.$refs['dataForm'].validate((valid) => {
        if (valid) {
          const _this = this
          const d = this.temp
          if (typeof (d.img) === 'object') {
            d.img = d.img.join(',')
          }
          save(d).then(response => {
            if (response.status === 1) {
              if (!d.id) {
                d.id = response.data.id
              }
              this.$emit('updateRow', d)
              _this.dialogFormVisible = false
              _this.$message.success(response.msg)
            } else {
              _this.$message.error(response.msg)
            }
            _this.btnLoading = false
          }).catch((error) => {
            this.btnLoading = false
          })
        } else {
          this.btnLoading = false
        }
      })
    }
  }
}
</script>
