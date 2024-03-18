import argparse

def convert(input_file):
  return len(input_file)


if __name__ == "__main__":

  parser = argparse.ArgumentParser()
  parser.add_argument("--input_file",required=True,type=string)
  parser.add_argument("--output_dir", type=string,default='./')
  args = parser.parse_args()
