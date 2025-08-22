-- CreateEnum
CREATE TYPE "UserType" AS ENUM ('PWD', 'Employer', 'Administrator');

-- CreateEnum
CREATE TYPE "AccountStatus" AS ENUM ('Active', 'Inactive', 'Suspended', 'Deleted');

-- CreateEnum
CREATE TYPE "Disability_Severity" AS ENUM ('Mild', 'Moderate', 'Severe');

-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('Male', 'Female', 'Other');

-- CreateTable
CREATE TABLE "Users" (
    "user_Id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "password_hash" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL,
    "user_type" "UserType" NOT NULL,
    "account_status" "AccountStatus" NOT NULL DEFAULT 'Active',
    "is_verified" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TEXT NOT NULL,

    CONSTRAINT "Users_pkey" PRIMARY KEY ("user_Id")
);

-- CreateTable
CREATE TABLE "Pwd_Profile" (
    "pwd_Id" SERIAL NOT NULL,
    "user_Id" INTEGER NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "middle_name" TEXT NOT NULL,
    "profile_picture" TEXT NOT NULL,
    "bio" TEXT NOT NULL,
    "disability_Type" TEXT NOT NULL,
    "disability_severity" "Disability_Severity" NOT NULL,
    "accessibility_Needs" TEXT NOT NULL,
    "location_City" TEXT NOT NULL,
    "location_Province" TEXT NOT NULL,
    "location_Country" TEXT NOT NULL,
    "date_of_birth" TEXT NOT NULL,
    "gender" "Gender" NOT NULL,
    "rating" DOUBLE PRECISION NOT NULL DEFAULT 0.0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Pwd_Profile_pkey" PRIMARY KEY ("pwd_Id")
);

-- CreateTable
CREATE TABLE "Employer_Profile" (
    "employer_Id" SERIAL NOT NULL,
    "user_Id" INTEGER NOT NULL,
    "company_name" TEXT NOT NULL,
    "company_logo" TEXT NOT NULL,
    "company_description" TEXT NOT NULL,
    "accessibility_features" TEXT NOT NULL,
    "industry" TEXT NOT NULL,
    "location_City" TEXT NOT NULL,
    "location_Province" TEXT NOT NULL,
    "location_Country" TEXT NOT NULL,
    "rating" DOUBLE PRECISION NOT NULL DEFAULT 0.0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Employer_Profile_pkey" PRIMARY KEY ("employer_Id")
);

-- CreateTable
CREATE TABLE "Chat_Thread" (
    "thread_Id" SERIAL NOT NULL,
    "application_Id" INTEGER NOT NULL,
    "pwd_Id" INTEGER NOT NULL,
    "employer_Id" INTEGER NOT NULL,
    "created_at" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Chat_Thread_pkey" PRIMARY KEY ("thread_Id")
);

-- CreateTable
CREATE TABLE "Chat_Message" (
    "message_Id" SERIAL NOT NULL,
    "thread_Id" INTEGER NOT NULL,
    "sender_Id" INTEGER NOT NULL,
    "content" TEXT NOT NULL,
    "created_at" TEXT NOT NULL,

    CONSTRAINT "Chat_Message_pkey" PRIMARY KEY ("message_Id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Users_email_key" ON "Users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Users_phone_number_key" ON "Users"("phone_number");

-- CreateIndex
CREATE UNIQUE INDEX "Pwd_Profile_user_Id_key" ON "Pwd_Profile"("user_Id");

-- CreateIndex
CREATE UNIQUE INDEX "Employer_Profile_user_Id_key" ON "Employer_Profile"("user_Id");

-- AddForeignKey
ALTER TABLE "Pwd_Profile" ADD CONSTRAINT "Pwd_Profile_user_Id_fkey" FOREIGN KEY ("user_Id") REFERENCES "Users"("user_Id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Employer_Profile" ADD CONSTRAINT "Employer_Profile_user_Id_fkey" FOREIGN KEY ("user_Id") REFERENCES "Users"("user_Id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Chat_Message" ADD CONSTRAINT "Chat_Message_thread_Id_fkey" FOREIGN KEY ("thread_Id") REFERENCES "Chat_Thread"("thread_Id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Chat_Message" ADD CONSTRAINT "Chat_Message_sender_Id_fkey" FOREIGN KEY ("sender_Id") REFERENCES "Users"("user_Id") ON DELETE CASCADE ON UPDATE CASCADE;
