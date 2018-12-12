<template>
  <div class="upload-container">
    <el-upload
			class="avatar-uploader"
			action=""
			:show-file-list="false"
			:on-success="handleAvatarSuccess"
			:before-upload="beforeAvatarUpload">
			<img v-if="imageUrl" :src="imageUrl" class="avatar">
			<i v-else class="el-icon-plus avatar-uploader-icon"></i>
		</el-upload>
  </div>
</template>

<script>
import { getToken } from '@/api/qiniu'

export default {
	name: 'SingleImageUpload',
	props: {
		value: {
			type: String,
			default: ''
		}
	},
	data() {
		return {
			imageUrl: this.value
		};
	},
	methods: {
		handleAvatarSuccess(res, file) {
			this.imageUrl = URL.createObjectURL(file.raw);
		},
		beforeAvatarUpload(file) {
			const isJPG = file.type === 'image/jpeg';
			const isLt2M = file.size / 1024 / 1024 < 2;
				
			if (!isJPG) {
				this.$message.error('上传头像图片只能是 JPG 格式!');
			}
			if (!isLt2M) {
				this.$message.error('上传头像图片大小不能超过 2MB!');
			}
			return isJPG && isLt2M;
		}
	}
}
</script>
<style rel="stylesheet/scss" lang="scss">
	.avatar-uploader {
		width: 178px;
		height: 178px;
		.el-upload {
			border: 1px dashed #d9d9d9;
			border-radius: 6px;
			cursor: pointer;
			position: relative;
			overflow: hidden;
			&:hover{
				border-color: #409EFF;
			}
		}
		
		.avatar {
			width: 178px;
			height: 178px;
			display: block;
		}
		.avatar-uploader-icon {
			font-size: 28px;
			color: #8c939d;
			width: 178px;
			height: 178px;
			line-height: 178px;
			text-align: center;
		}
		
	}
</style>