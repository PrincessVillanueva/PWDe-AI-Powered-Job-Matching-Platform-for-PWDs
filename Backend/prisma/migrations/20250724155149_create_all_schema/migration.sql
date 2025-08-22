/*
  Warnings:

  - The primary key for the `Chat_Message` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `message_Id` on the `Chat_Message` table. All the data in the column will be lost.
  - You are about to drop the column `sender_Id` on the `Chat_Message` table. All the data in the column will be lost.
  - You are about to drop the column `thread_Id` on the `Chat_Message` table. All the data in the column will be lost.
  - The `created_at` column on the `Chat_Message` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `Chat_Thread` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `application_Id` on the `Chat_Thread` table. All the data in the column will be lost.
  - You are about to drop the column `employer_Id` on the `Chat_Thread` table. All the data in the column will be lost.
  - You are about to drop the column `pwd_Id` on the `Chat_Thread` table. All the data in the column will be lost.
  - You are about to drop the column `thread_Id` on the `Chat_Thread` table. All the data in the column will be lost.
  - The `created_at` column on the `Chat_Thread` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `Employer_Profile` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `employer_Id` on the `Employer_Profile` table. All the data in the column will be lost.
  - You are about to drop the column `user_Id` on the `Employer_Profile` table. All the data in the column will be lost.
  - The primary key for the `Pwd_Profile` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `pwd_Id` on the `Pwd_Profile` table. All the data in the column will be lost.
  - You are about to drop the column `user_Id` on the `Pwd_Profile` table. All the data in the column will be lost.
  - The primary key for the `Users` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `user_Id` on the `Users` table. All the data in the column will be lost.
  - The `created_at` column on the `Users` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - A unique constraint covering the columns `[user_id]` on the table `Employer_Profile` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[user_id]` on the table `Pwd_Profile` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `sender_id` to the `Chat_Message` table without a default value. This is not possible if the table is not empty.
  - Added the required column `thread_id` to the `Chat_Message` table without a default value. This is not possible if the table is not empty.
  - Added the required column `application_id` to the `Chat_Thread` table without a default value. This is not possible if the table is not empty.
  - Added the required column `employer_id` to the `Chat_Thread` table without a default value. This is not possible if the table is not empty.
  - Added the required column `pwd_id` to the `Chat_Thread` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `Employer_Profile` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `Pwd_Profile` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `date_of_birth` on the `Pwd_Profile` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "EmploymentType" AS ENUM ('Full_time', 'Part_time', 'Contract', 'Freelance', 'Internship');

-- CreateEnum
CREATE TYPE "WorkArrangement" AS ENUM ('On_site', 'Remote', 'Hybrid');

-- CreateEnum
CREATE TYPE "SalaryType" AS ENUM ('Hourly', 'Daily', 'Monthly', 'Annually', 'Milestone_based');

-- CreateEnum
CREATE TYPE "ExperienceLevel" AS ENUM ('Entry', 'Mid', 'Senior', 'Executive');

-- CreateEnum
CREATE TYPE "TicketCategory" AS ENUM ('Technical', 'Account', 'Payment', 'Discrimination', 'Accessibility', 'Other');

-- CreateEnum
CREATE TYPE "TicketPriority" AS ENUM ('Low', 'Medium', 'High', 'Urgent');

-- CreateEnum
CREATE TYPE "TicketStatus" AS ENUM ('Open', 'In_Progress', 'Resolved', 'Closed');

-- CreateEnum
CREATE TYPE "TargetAudience" AS ENUM ('PWD', 'Employer', 'All');

-- CreateEnum
CREATE TYPE "WithdrawalStatus" AS ENUM ('Pending', 'Approved', 'Rejected', 'Processed');

-- CreateEnum
CREATE TYPE "TransactionType" AS ENUM ('Payment', 'Withdrawal', 'Refund', 'Fee');

-- CreateEnum
CREATE TYPE "TransactionStatus" AS ENUM ('Pending', 'Completed', 'Failed', 'Cancelled');

-- CreateEnum
CREATE TYPE "ReviewerType" AS ENUM ('Employer', 'Job_Seeker');

-- DropForeignKey
ALTER TABLE "Chat_Message" DROP CONSTRAINT "Chat_Message_sender_Id_fkey";

-- DropForeignKey
ALTER TABLE "Chat_Message" DROP CONSTRAINT "Chat_Message_thread_Id_fkey";

-- DropForeignKey
ALTER TABLE "Employer_Profile" DROP CONSTRAINT "Employer_Profile_user_Id_fkey";

-- DropForeignKey
ALTER TABLE "Pwd_Profile" DROP CONSTRAINT "Pwd_Profile_user_Id_fkey";

-- DropIndex
DROP INDEX "Employer_Profile_user_Id_key";

-- DropIndex
DROP INDEX "Pwd_Profile_user_Id_key";

-- AlterTable
ALTER TABLE "Chat_Message" DROP CONSTRAINT "Chat_Message_pkey",
DROP COLUMN "message_Id",
DROP COLUMN "sender_Id",
DROP COLUMN "thread_Id",
ADD COLUMN     "message_id" SERIAL NOT NULL,
ADD COLUMN     "sender_id" INTEGER NOT NULL,
ADD COLUMN     "thread_id" INTEGER NOT NULL,
DROP COLUMN "created_at",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD CONSTRAINT "Chat_Message_pkey" PRIMARY KEY ("message_id");

-- AlterTable
ALTER TABLE "Chat_Thread" DROP CONSTRAINT "Chat_Thread_pkey",
DROP COLUMN "application_Id",
DROP COLUMN "employer_Id",
DROP COLUMN "pwd_Id",
DROP COLUMN "thread_Id",
ADD COLUMN     "application_id" INTEGER NOT NULL,
ADD COLUMN     "employer_id" INTEGER NOT NULL,
ADD COLUMN     "pwd_id" INTEGER NOT NULL,
ADD COLUMN     "thread_id" SERIAL NOT NULL,
DROP COLUMN "created_at",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD CONSTRAINT "Chat_Thread_pkey" PRIMARY KEY ("thread_id");

-- AlterTable
ALTER TABLE "Employer_Profile" DROP CONSTRAINT "Employer_Profile_pkey",
DROP COLUMN "employer_Id",
DROP COLUMN "user_Id",
ADD COLUMN     "employer_id" SERIAL NOT NULL,
ADD COLUMN     "user_id" INTEGER NOT NULL,
ADD CONSTRAINT "Employer_Profile_pkey" PRIMARY KEY ("employer_id");

-- AlterTable
ALTER TABLE "Pwd_Profile" DROP CONSTRAINT "Pwd_Profile_pkey",
DROP COLUMN "pwd_Id",
DROP COLUMN "user_Id",
ADD COLUMN     "pwd_id" SERIAL NOT NULL,
ADD COLUMN     "user_id" INTEGER NOT NULL,
DROP COLUMN "date_of_birth",
ADD COLUMN     "date_of_birth" TIMESTAMP(3) NOT NULL,
ADD CONSTRAINT "Pwd_Profile_pkey" PRIMARY KEY ("pwd_id");

-- AlterTable
ALTER TABLE "Users" DROP CONSTRAINT "Users_pkey",
DROP COLUMN "user_Id",
ADD COLUMN     "user_id" SERIAL NOT NULL,
DROP COLUMN "created_at",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD CONSTRAINT "Users_pkey" PRIMARY KEY ("user_id");

-- CreateTable
CREATE TABLE "Resumes" (
    "resume_id" SERIAL NOT NULL,
    "pwd_id" INTEGER NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "summary" TEXT NOT NULL,
    "skills" TEXT NOT NULL,
    "work_experience" TEXT NOT NULL,
    "education" TEXT NOT NULL,
    "certifications" TEXT NOT NULL,
    "achievements" TEXT NOT NULL,
    "file_path" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Resumes_pkey" PRIMARY KEY ("resume_id")
);

-- CreateTable
CREATE TABLE "withdrawal_requests" (
    "withdrawal_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "amount" DECIMAL(10,2) NOT NULL,
    "payment_method" VARCHAR(50) NOT NULL,
    "status" "WithdrawalStatus" NOT NULL,
    "requested_at" TIMESTAMP(3) NOT NULL,
    "processed_at" TIMESTAMP(3) NOT NULL,
    "processed_by" INTEGER NOT NULL,

    CONSTRAINT "withdrawal_requests_pkey" PRIMARY KEY ("withdrawal_id")
);

-- CreateTable
CREATE TABLE "Applications" (
    "application_id" SERIAL NOT NULL,
    "job_id" INTEGER NOT NULL,
    "pwd_id" INTEGER NOT NULL,
    "resume_id" INTEGER NOT NULL,
    "custom_message" TEXT NOT NULL,
    "proposed_salary" DECIMAL(10,2) NOT NULL,
    "submitted_at" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "status_changed_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Applications_pkey" PRIMARY KEY ("application_id")
);

-- CreateTable
CREATE TABLE "reviews" (
    "review_id" SERIAL NOT NULL,
    "reviewer_id" INTEGER NOT NULL,
    "reviewee_id" INTEGER NOT NULL,
    "application_id" INTEGER NOT NULL,
    "rating" INTEGER NOT NULL,
    "comment" TEXT NOT NULL,
    "reviewer_type" "ReviewerType" NOT NULL,
    "is_public" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reviews_pkey" PRIMARY KEY ("review_id")
);

-- CreateTable
CREATE TABLE "transactions" (
    "transaction_id" SERIAL NOT NULL,
    "payer_id" INTEGER NOT NULL,
    "payee_id" INTEGER NOT NULL,
    "application_id" INTEGER NOT NULL,
    "amount" DECIMAL(10,2) NOT NULL,
    "payment_method" VARCHAR(50) NOT NULL,
    "transaction_type" "TransactionType" NOT NULL,
    "status" "TransactionStatus" NOT NULL,
    "reference_number" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "processed_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "transactions_pkey" PRIMARY KEY ("transaction_id")
);

-- CreateTable
CREATE TABLE "Notifications" (
    "notification_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "is_read" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "read_at" TIMESTAMP(3),

    CONSTRAINT "Notifications_pkey" PRIMARY KEY ("notification_id")
);

-- CreateTable
CREATE TABLE "Job_Categories" (
    "category_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "Job_Categories_pkey" PRIMARY KEY ("category_id")
);

-- CreateTable
CREATE TABLE "Job_Listings" (
    "job_id" SERIAL NOT NULL,
    "employer_id" INTEGER NOT NULL,
    "category_id" INTEGER NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "description" TEXT NOT NULL,
    "skills_required" TEXT NOT NULL,
    "employment_type" "EmploymentType" NOT NULL,
    "work_arrangement" "WorkArrangement" NOT NULL,
    "salary_min" DECIMAL(10,2) NOT NULL,
    "salary_max" DECIMAL(10,2) NOT NULL,
    "salary_type" "SalaryType" NOT NULL,
    "location_city" VARCHAR(100) NOT NULL,
    "location_province" VARCHAR(100) NOT NULL,
    "location_country" VARCHAR(100) NOT NULL,
    "accessibility_features" TEXT NOT NULL,
    "experience_level" "ExperienceLevel" NOT NULL,
    "application_deadline" DATE NOT NULL,
    "applications_count" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Job_Listings_pkey" PRIMARY KEY ("job_id")
);

-- CreateTable
CREATE TABLE "support_tickets" (
    "ticket_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "subject" VARCHAR(255) NOT NULL,
    "description" TEXT NOT NULL,
    "category" "TicketCategory" NOT NULL,
    "priority" "TicketPriority" NOT NULL,
    "status" "TicketStatus" NOT NULL,
    "assigned_to" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "support_tickets_pkey" PRIMARY KEY ("ticket_id")
);

-- CreateTable
CREATE TABLE "resources" (
    "resource_id" SERIAL NOT NULL,
    "created_by" INTEGER NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "description" TEXT NOT NULL,
    "resource_type" VARCHAR(100) NOT NULL,
    "file_path" TEXT NOT NULL,
    "category" VARCHAR(100) NOT NULL,
    "target_audience" "TargetAudience" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "resources_pkey" PRIMARY KEY ("resource_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Job_Categories_name_key" ON "Job_Categories"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Employer_Profile_user_id_key" ON "Employer_Profile"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "Pwd_Profile_user_id_key" ON "Pwd_Profile"("user_id");

-- AddForeignKey
ALTER TABLE "Pwd_Profile" ADD CONSTRAINT "Pwd_Profile_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Employer_Profile" ADD CONSTRAINT "Employer_Profile_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Resumes" ADD CONSTRAINT "Resumes_pwd_id_fkey" FOREIGN KEY ("pwd_id") REFERENCES "Pwd_Profile"("pwd_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Chat_Message" ADD CONSTRAINT "Chat_Message_thread_id_fkey" FOREIGN KEY ("thread_id") REFERENCES "Chat_Thread"("thread_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Chat_Message" ADD CONSTRAINT "Chat_Message_sender_id_fkey" FOREIGN KEY ("sender_id") REFERENCES "Users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "withdrawal_requests" ADD CONSTRAINT "withdrawal_requests_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "withdrawal_requests" ADD CONSTRAINT "withdrawal_requests_processed_by_fkey" FOREIGN KEY ("processed_by") REFERENCES "Users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Applications" ADD CONSTRAINT "Applications_job_id_fkey" FOREIGN KEY ("job_id") REFERENCES "Job_Listings"("job_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Applications" ADD CONSTRAINT "Applications_pwd_id_fkey" FOREIGN KEY ("pwd_id") REFERENCES "Pwd_Profile"("pwd_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Applications" ADD CONSTRAINT "Applications_resume_id_fkey" FOREIGN KEY ("resume_id") REFERENCES "Resumes"("resume_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_reviewer_id_fkey" FOREIGN KEY ("reviewer_id") REFERENCES "Users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_reviewee_id_fkey" FOREIGN KEY ("reviewee_id") REFERENCES "Users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_application_id_fkey" FOREIGN KEY ("application_id") REFERENCES "Applications"("application_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_payer_id_fkey" FOREIGN KEY ("payer_id") REFERENCES "Employer_Profile"("employer_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_payee_id_fkey" FOREIGN KEY ("payee_id") REFERENCES "Pwd_Profile"("pwd_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_application_id_fkey" FOREIGN KEY ("application_id") REFERENCES "Applications"("application_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notifications" ADD CONSTRAINT "Notifications_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Job_Listings" ADD CONSTRAINT "Job_Listings_employer_id_fkey" FOREIGN KEY ("employer_id") REFERENCES "Employer_Profile"("employer_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Job_Listings" ADD CONSTRAINT "Job_Listings_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "Job_Categories"("category_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "support_tickets" ADD CONSTRAINT "support_tickets_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "support_tickets" ADD CONSTRAINT "support_tickets_assigned_to_fkey" FOREIGN KEY ("assigned_to") REFERENCES "Users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "resources" ADD CONSTRAINT "resources_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "Users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;
