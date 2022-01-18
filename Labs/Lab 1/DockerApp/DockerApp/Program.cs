using System;

namespace DockerApp
{
    enum Scales
    {
        celsius = 'c',
        fahrenheit = 'f'
    }

    class ParseData
    {
        public Scales scaleFrom, scaleTo;
        public int value;

        public ParseData(string scaleFrom, string scaleTo, string value)
        {
            TryParseScale(scaleFrom, ref this.scaleFrom);
            TryParseScale(scaleTo, ref this.scaleTo);
            int.TryParse(value, out this.value);
        }

        private bool TryParseScale(string arg, ref Scales scale)
        {
            if ((arg.Length == 2) &&
                Scales.IsDefined(typeof(Scales), (Scales)arg[1]) &&
                (arg[0] == '-'))
            {
                scale = (Scales)arg[1];
                return true;
            }
            return false;
        }

        public int Convert()
        {
            return 0;
        }
    }
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine(
                @"This is a simple temperature converter. 
Please specify your input as follows:
[-c|-f] <VALUE> [-c|-f]
-c — celsius degrees
-f — fahrenheit degrees"
            );
            if (args.Length < 3)
            {
                //TODO
            }
            else if (args.Length > 3)
            {
                //TODO
            }
            else
            {
                var parseData = new ParseData(args[0], args[1], args[2]);
                int result = parseData.Convert();
                Console.WriteLine($"\nResult: {result}");
            }
        }
    }
}