import os
import argparse

def convert(input_file):
  return len(input_file)


if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument("--input_file",required=True,type=string)
    parser.add_argument("--output_dir", type=string,default='./outputs')
    args = parser.parse_args()


    input_file = args.input_file
    output = convert(input_file)

    with open(os.path.join(args.output_dir,os.path.basename(input_file)),'w') as out:
        out.write(output+'\n')
