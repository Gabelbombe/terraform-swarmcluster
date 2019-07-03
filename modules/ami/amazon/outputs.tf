output "image_id" {
  description = "Image ID taken from data filtering"
  value       = "${data.aws_ami.ami.image_id}"
}
