// import { Router } from "express";
// import multer from "multer";
// import {
//   deleteFile,
//   getFileById,
//   uploadFile,
// } from "../controllers/attachmentController.js";

// const router = Router();
// const upload = multer(); // بدون إعدادات يخزن الملف في الذاكرة (buffer)

// router.post("/upload", upload.single("file"), uploadFile); // مهم جداً

// router.get("/file/:id", getFileById);
// router.delete("/file/:id", deleteFile);

// export default router;


import { Router } from "express";
import multer from "multer";
import {
  deleteFile,
  getFileById,
  uploadFile,
  uploadLessonAttachment,
  uploadSubmissionAttachment,
  getLessonAttachments,
  getSubmissionAttachments,
} from "../controllers/attachmentController.js";
import { authenticate } from "../middlewares/authMiddleware.js";

const router = Router();
const upload = multer();

// Routes for general attachments
router.post("/upload", authenticate, upload.single("file"), uploadFile);
router.get("/file/:id", authenticate, getFileById);
router.delete("/file/:id", authenticate, deleteFile);

// Routes for lesson attachments
router.post("/lessons/:lessonId/upload", authenticate, upload.single("file"), uploadLessonAttachment);
router.get("/lessons/:lessonId", authenticate, getLessonAttachments);

// Routes for submission attachments
router.post("/submissions/:submissionId/upload", authenticate, upload.single("file"), uploadSubmissionAttachment);
router.get("/submissions/:submissionId", authenticate, getSubmissionAttachments);

export default router;