import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/constants.dart';
import '../services/google_sheets_api.dart';

Future<dynamic> portfolioModalSheet(BuildContext context, bool isDark) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: isDark ? const Color(0xFF272727) : gCardBgColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    builder: (context) => Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 30, right:30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Portfolio Values',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            'Get your current portfolio details',
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: fontSubHeading,
                ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: isDark ? Colors.black26 : Colors.grey.shade200,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.trending_up_rounded,
                  size: 45.0,
                  color: fontSubHeading,
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Amount',
                      style: GoogleFonts.poppins(
                        color: fontSubHeading,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '₹ ${GoogleSheetsApi.currentAmt}',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontSize: 18),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20.0),

          //
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: isDark ? Colors.black26 : Colors.grey.shade200,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.money,
                  size: 45.0,
                  color: fontSubHeading,
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invested Amount',
                      style: GoogleFonts.poppins(
                        color: fontSubHeading,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '₹ ${GoogleSheetsApi.investedAmt}',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontSize: 18),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20.0),

          //
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: isDark ? Colors.black26 : Colors.grey.shade200,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.currency_rupee_sharp,
                  size: 45.0,
                  color: fontSubHeading,
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Unrealized Gains',
                      style: GoogleFonts.poppins(
                        color: fontSubHeading,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '₹ ${GoogleSheetsApi.totalGains}',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontSize: 18),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20.0),

          //
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: isDark ? Colors.black26 : Colors.grey.shade200,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.percent_rounded,
                  size: 45.0,
                  color: fontSubHeading,
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Growth Percentage',
                      style: GoogleFonts.poppins(
                        color: fontSubHeading,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${GoogleSheetsApi.gainsPercent} %',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontSize: 18),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    ),
  );
}
