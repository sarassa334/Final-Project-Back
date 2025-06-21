// // models/Attachment.js
// import { pool } from "../config/db.js";

// const AttachmentModel = {
//   async createAttachment(original_name, mime_type, size, public_id, secure_url, format) {
//     try {
//       const { rows } = await pool.query(
//         `INSERT INTO attachments 
//           (original_name, mime_type, size, public_id, secure_url, format)
//          VALUES ($1, $2, $3, $4, $5, $6)
//          RETURNING *`,
//         [original_name, mime_type, size, public_id, secure_url, format]
//       );
//       return rows[0];
//     } catch (error) {
//       throw error;
//     }
//   },

//   async   getAttachmentById(id) {
//     try {
//       const { rows } = await pool.query(
//         `SELECT * FROM attachments WHERE id = $1`,
//         [id]
//       );
//       return rows[0];
//     } catch (error) {
//       throw error;
//     }
//   },

//   async deleteAttachment(id) {
//     try {
//       const { rows } = await pool.query(
//         `DELETE FROM attachments WHERE id = $1 RETURNING *`,
//         [id]
//       );
//       return rows[0];
//     } catch (error) {
//       throw error;
//     }
//   }
// };

// export default AttachmentModel;



import { pool } from "../config/db.js";

const AttachmentModel = {
  async createAttachment(original_name, mime_type, size, public_id, secure_url, format, lesson_id = null, submission_id = null) {
    try {
      const { rows } = await pool.query(
        `INSERT INTO attachments 
          (original_name, mime_type, size, public_id, secure_url, format, lesson_id, submission_id)
         VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
         RETURNING *`,
        [original_name, mime_type, size, public_id, secure_url, format, lesson_id, submission_id]
      );
      return rows[0];
    } catch (error) {
      throw error;
    }
  },

  async getAttachmentById(id) {
    try {
      const { rows } = await pool.query(
        `SELECT * FROM attachments WHERE id = $1`,
        [id]
      );
      return rows[0];
    } catch (error) {
      throw error;
    }
  },

  async deleteAttachment(id) {
    try {
      const { rows } = await pool.query(
        `DELETE FROM attachments WHERE id = $1 RETURNING *`,
        [id]
      );
      return rows[0];
    } catch (error) {
      throw error;
    }
  },

  async getByLessonId(lessonId) {
    try {
      const { rows } = await pool.query(
        `SELECT * FROM attachments WHERE lesson_id = $1`,
        [lessonId]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  },

  async getBySubmissionId(submissionId) {
    try {
      const { rows } = await pool.query(
        `SELECT * FROM attachments WHERE submission_id = $1`,
        [submissionId]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  },

  async updateAttachmentRelation(id, lesson_id = null, submission_id = null) {
    try {
      const { rows } = await pool.query(
        `UPDATE attachments 
         SET lesson_id = $1, submission_id = $2 
         WHERE id = $3
         RETURNING *`,
        [lesson_id, submission_id, id]
      );
      return rows[0];
    } catch (error) {
      throw error;
    }
  }
};

export default AttachmentModel;