import SubmissionModel from "../models/Submission.js";
import AssignmentModel from "../models/Assignment.js";
import LessonModel from "../models/Lesson.js";
import ModuleModel from "../models/Module.js";
import CourseModel from "../models/Course.js";
import AttachmentModel from "../models/Attachment.js";

const SubmissionController = {
 async submitAssignment(req, res, next) {
  try {
    const { assignment_id, submission_url, attachment_id } = req.body;

    const submission = await SubmissionModel.create({
      assignment_id,
      user_id: req.user.id,
      submission_url,
      attachment_id
    });

    // إذا كان هناك مرفق، نربطه بالتسليم
    if (attachment_id) {
      await AttachmentModel.updateAttachmentRelation(attachment_id, null, submission.id);
    }

    res.status(201).json({
      success: true,
      submission,
    });
  } catch (error) {
    next(error);
  }
},

  async getSubmission(req, res, next) {
    try {
      const submission = await SubmissionModel.findById(req.params.id);
      if (!submission) {
        return res.status(404).json({
          success: false,
          message: "Submission not found",
        });
      }

      // Authorization check
      if (req.user.role === "student" && submission.user_id !== req.user.id) {
        return res.status(403).json({
          success: false,
          message: "Unauthorized to view this submission",
        });
      }

      res.json({
        success: true,
        submission,
      });
    } catch (error) {
      next(error);
    }
  },

  async getSubmissionsByAssignment(req, res, next) {
    try {
      // Verify assignment exists and get course info
      const assignment = await AssignmentModel.findById(
        req.params.assignmentId
      );
      if (!assignment) {
        return res.status(404).json({
          success: false,
          message: "Assignment not found",
        });
      }

      const lesson = await LessonModel.findById(assignment.lesson_id);
      const module = await ModuleModel.findById(lesson.module_id);
      const course = await CourseModel.findById(module.course_id);

      // Authorization check
      if (
        req.user.role === "student" ||
        (req.user.role === "instructor" && course.instructor_id !== req.user.id)
      ) {
        return res.status(403).json({
          success: false,
          message: "Studant not allow to view these submissions",
        });
      }

      const submissions = await SubmissionModel.findByAssignmentId(
        req.params.assignmentId
      );
      res.json({
        success: true,
        data: submissions,
      });
    } catch (error) {
      next(error);
    }
  },

  async gradeSubmission(req, res, next) {
    try {
      const submission = await SubmissionModel.findById(req.params.id);
      if (!submission) {
        return res.status(404).json({
          success: false,
          message: "Submission not found",
        });
      }

      // Get course info for authorization
      const assignment = await AssignmentModel.findById(
        submission.assignment_id
      );
      const lesson = await LessonModel.findById(assignment.lesson_id);
      const module = await ModuleModel.findById(lesson.module_id);
      const course = await CourseModel.findById(module.course_id);

      // Only instructor or admin can grade
      if (course.instructor_id !== req.user.id) {
        return res.status(403).json({
          success: false,
          message: "Unauthorized to grade this submission",
        });
      }

      const updatedSubmission = await SubmissionModel.grade(
        req.params.id,
        req.body.grade,
        req.body.feedback
      );

      res.json({
        success: true,
        submission: updatedSubmission,
      });
    } catch (error) {
      next(error);
    }
  },

  async deleteSubmission(req, res, next) {
    try {
      const submission = await SubmissionModel.findById(req.params.id);
      if (!submission) {
        return res.status(404).json({
          success: false,
          message: "Submission not found",
        });
      }

      let isAuthorized = false;

      if (req.user.role === "admin") {
        isAuthorized = true;
      } else if (req.user.role === "instructor") {
        const assignment = await AssignmentModel.findById(
          submission.assignment_id
        );
        const lesson = await LessonModel.findById(assignment.lesson_id);
        const module = await ModuleModel.findById(lesson.module_id);
        const course = await CourseModel.findById(module.course_id);
        if (course.instructor_id === req.user.id) isAuthorized = true;
      } else if (
        req.user.role === "student" &&
        submission.user_id === req.user.id
      ) {
        isAuthorized = true;
      }

      if (!isAuthorized) {
        return res.status(403).json({
          success: false,
          message: "Unauthorized to delete this submission",
        });
      }

      await SubmissionModel.delete(req.params.id);
      res.json({
        success: true,
        message: "Submission deleted successfully",
      });
    } catch (error) {
      next(error);
    }
  },
};

export default SubmissionController;
